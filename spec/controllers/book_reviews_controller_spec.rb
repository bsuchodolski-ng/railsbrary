require 'rails_helper'

RSpec.describe BookReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:book) { create(:book) }
  let(:book_review) { create(:book_review, book: book, user: user) }
  let(:other_user_book_review) { create(:book_review, book: book, user: other_user) }

  before do
    sign_in(user)
  end

  describe 'GET #new' do
    subject { get :new, params: { book_id: book.id }, xhr: true }

    it 'responds with 200' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'when creating review as current user' do
      subject do
        post :create, xhr: true, params: {
          book_id: book.id,
          book_review: {
            book_id: book.id,
            user_id: user.id,
            body: 'Great book'
          }
        }
      end

      it 'create a review' do
        expect {subject}.to change { BookReview.count }.by(1)
      end
    end

    context 'when creating review as other user' do
      subject do
        post :create, xhr: true, params: {
          book_id: book.id,
          book_review: {
            book_id: book.id,
            user_id: other_user.id,
            body: 'Great book'
          }
        }
      end

      it 'raises not athorized error' do
        expect { subject }.to raise_exception(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { book_id: book.id, id: book_review.id }, xhr: true }

    it 'responds with 200' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'PATCH #update' do
    context 'when updating owned review' do
      subject do
        patch :update, xhr: true, params: {
          book_id: book.id,
          id: book_review.id,
          book_review: {
            book_id: book.id,
            user_id: user.id,
            body: 'Disaster'
          }
        }
      end

      it 'updates the review' do
        expect {subject}.to change { book_review.reload.body }.from('Great book').to('Disaster')
      end
    end

    context 'when updating other user\'s review' do
      subject do
        patch :update, xhr: true, params: {
          book_id: book.id,
          id: other_user_book_review.id,
          book_review: {
            book_id: book.id,
            user_id: user.id,
            body: 'Disaster'
          }
        }
      end

      it 'raises not authorized error' do
        expect { subject }.to raise_exception(Pundit::NotAuthorizedError)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when deleting owned review' do
      subject do
        delete :destroy, xhr: true, params: {
          book_id: book.id,
          id: book_review.id
        }
      end

      it 'deletes book review' do
        book_review
        expect { subject }.to change { BookReview.count }.by(-1)
      end
    end

    context 'when deleting other user review' do
      subject do
        delete :destroy, xhr: true, params: {
          book_id: book.id,
          id: other_user_book_review.id
        }
      end

      it 'raises not authorized error' do
        expect { subject }.to raise_exception(Pundit::NotAuthorizedError)
      end
    end
  end
end
