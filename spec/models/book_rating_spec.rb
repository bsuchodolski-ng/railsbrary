require 'rails_helper'

RSpec.describe BookRating, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:book_id) }
  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
  it { is_expected.to validate_uniqueness_of(:book_id)
    .scoped_to(:user_id).with_message("was already rated") }
  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:user) }

  describe '#recalculate_book_average_rating' do
    let(:book_rating) { create(:book_rating) }
    let(:book) { book_rating.book }

    it 'triggers book to recalculate average rating' do
      expect(book).to receive(:recalculate_average_rating)
      book_rating.send(:recalculate_book_average_rating)
    end
  end

  describe 'callbacks' do
    let(:book_rating) { create(:book_rating) }
    let(:new_book_rating) { build(:book_rating) }
    it 'triggers #recalculate_book_average_rating on create' do
      expect(new_book_rating).to receive(:recalculate_book_average_rating)
      new_book_rating.save
    end

    it 'triggers #recalculate_book_average_rating on update' do
      expect(book_rating).to receive(:recalculate_book_average_rating)
      book_rating.save
    end

    it 'triggers #recalculate_book_average_rating on destroy' do
      expect(book_rating).to receive(:recalculate_book_average_rating)
      book_rating.destroy
    end
  end
end
