require 'rails_helper'

RSpec.describe BookRatingsController, type: :controller do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  before do
    sign_in(user)
  end

  describe 'POST #create' do
    context 'when rating is valid' do
      subject do
        post :create, xhr: true, params: {
          book_rating: {
            book_id: book.id,
            user_id: user.id,
            rating: 5
          }
        }
      end

      it 'creates new book rating' do
        expect { subject }.to change { BookRating.count }.by(1)
      end

      context 'when rating exist' do
        let!(:book_rating) { create(:book_rating, user: user, book: book) }

        it 'does not create new book rating' do
          expect { subject }.to_not change { BookRating.count }
        end
      end
    end

    context 'when rating is not valid' do
      subject do
        post :create, xhr: true, params: {
          book_rating: {
            book_id: book.id,
            user_id: user.id,
            rating: 9
          }
        }
      end

      it 'does not create new book rating' do
        expect { subject }.to_not change { BookRating.count }
      end
    end
  end

  describe 'PATCH #update' do
    let!(:book_rating) { create(:book_rating, user: user, book: book) }

    context 'when rating is present' do
      subject do
        patch :update, xhr: true, params: {
          id: book_rating.id,
          book_rating: {
            book_id: book.id,
            user_id: user.id,
            rating: 4
          }
        }
      end

      it 'updates book rating' do
        subject
        expect(book_rating.reload.rating).to eq 4
      end

      context 'when rating is not valid' do
        subject do
          patch :update, xhr: true, params: {
            id: book_rating.id,
            book_rating: {
              book_id: book.id,
              user_id: user.id,
              rating: 8
            }
          }
        end

        it 'does not update book rating' do
          expect(book_rating.reload.rating).to eq 5
        end
      end
    end

    context 'when rating is not present' do
      subject do
        patch :update, xhr: true, params: {
          id: book_rating.id,
          book_rating: {
            book_id: book.id,
            user_id: user.id,
            rating: ''
          }
        }
      end

      it 'deletes book rating' do
        expect { subject }.to change { BookRating.count }.by(-1)
      end
    end
  end
end
