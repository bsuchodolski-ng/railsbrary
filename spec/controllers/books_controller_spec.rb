require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user) { create(:user) }
  let(:book1) { create(:book, title: "Harry Potter pt 1") }
  let(:book2) { create(:book, title: "Harry Potter pt 2") }
  let(:book3) { create(:book, title: "Harry Potter pt 3") }
  let(:book4) { create(:book, title: "Something different") }

  before do
    sign_in(user)
  end

  describe 'GET #index' do
    context 'when user search with a term' do
      context 'and it does match one book' do
        before do
          get :index, params: { term: book4.title }
        end

        it 'returns only this one book' do
          expect(assigns[:books]).to eq [ book4 ]
        end
      end

      context 'and it does match multiple books' do
        before do
          get :index, params: { term: 'Potter' }
        end

        it 'returns all books that match the term' do
          expect(assigns[:books]).to include(book1, book2, book3)
        end

      end

      context 'and it does not match any books' do
        before do
          get :index, params: { term: 'Nothing' }
        end

        it 'returns empty array' do
          expect(assigns[:books]).to eq []
        end
      end
    end

    context 'when user does not search with a term' do
      before do
        get :index
      end

      it 'returns all books' do
        expect(assigns[:books]).to include(book1, book2, book3, book4)
      end
    end

    context 'when user filters by author name' do
      context 'and it does match a book' do
        before do
          get :index, params: {
            filters: {
              author: book4.author.name
            }
          }
        end

        it 'it returns book of this author' do
          expect(assigns[:books]).to eq [book4]
        end
      end

      context 'and it does not match any book' do
        before do
          get :index, params: {
            filters: {
              author: 'Unknown Author For Sure'
            }
          }
        end

        it 'returns empty array' do
          expect(assigns[:books]).to eq []
        end
      end
    end
  end
end
