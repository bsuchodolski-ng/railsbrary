require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:author_id) }
  it { is_expected.to belong_to(:author) }

  describe '#recalculate_average_rating' do
    let(:book) { create(:book) }
    let(:book_rating1) { create(:book_rating, book: book, rating: 5) }
    let(:book_rating2) { create(:book_rating, book: book, rating: 1) }
    let(:book_rating3) { create(:book_rating, book: book, rating: 3) }

    before do
      allow_any_instance_of(BookRating).to receive(:recalculate_book_average_rating)
    end

    context 'when book has couple of book ratings' do

      before do
        book.book_ratings << [book_rating1, book_rating2, book_rating3]
      end

      it 'calculates average rating of book ratings and updates it on book' do
        expect { book.recalculate_average_rating }.to change { book.reload.average_rating }.from(0.0).to(3.0)
      end
    end

    context 'when book has no book ratings' do
      before do
        book.update(average_rating: 5)
      end

      it 'updates book average rating with zero' do
        expect { book.recalculate_average_rating }.to change { book.reload.average_rating }.from(5.0).to(0.0)
      end
    end
  end
end
