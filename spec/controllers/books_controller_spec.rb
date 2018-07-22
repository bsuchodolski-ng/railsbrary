require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:user)   { create(:user) }
  let(:book1)  { create(:book, title: "Harry Potter pt 1") }
  let(:book2)  { create(:book, title: "Harry Potter pt 2") }
  let(:book3)  { create(:book, title: "Harry Potter pt 3") }
  let(:book4)  { create(:book, title: "Something different") }
  let(:author) { create(:author, name: "Henry Sienkiewicz") }
  let(:cover_image) { fixture_file_upload('files/cover.jpg', 'image/jpg') }
  let(:invalid_cover_image) { fixture_file_upload('files/invalid.pdf', 'application/pdf') }

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
          expect(assigns[:books]).to eq [book4]
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

    context 'when there are more than 25 books' do
      before { 30.times { create(:book) } }

      context 'when there is no page param in request' do
        subject { get :index }

        it 'returns paginated books' do
          subject
          expect(assigns[:books]).to eq Book.first(25)
        end
      end

      context 'when there user requests 2nd page' do
        subject { get :index, params: { page: 2 } }

        it 'returns paginated books' do
          subject
          expect(assigns[:books]).to eq Book.last(5)
        end
      end
    end
  end

  describe 'POST #create' do
    context 'when creating book with valid params' do
      subject do
        post :create, params: {
          book: {
            title: 'Quo Vadis',
            description: 'Great book',
            author_id: author.id
          }
        }
      end

      it 'creates a book' do
        expect { subject }.to change(Book, :count).by(1)
      end

      it 'informs user that action was successful via flash' do
        subject
        expect(controller).to set_flash[:success]
      end
    end

    context 'when creating book with invalid params' do
      subject do
        post :create, params: {
          book: {
            title: '',
            description: 'Great book',
            author_id: ''
          }
        }
      end

      it 'does not create a book' do
        expect { subject }.not_to change(Book, :count)
      end
    end

    context 'when creating book with cover image' do
      context 'when file has proper format' do
        subject do
          post :create, params: {
            book: {
              title: 'Book with cover',
              description: 'Great book',
              author_id: author.id,
              cover_image: cover_image
            }
          }
        end

        it 'creates a book' do
          expect { subject }.to change(Book, :count).by(1)
        end

        it 'book has image file attached' do
          subject
          expect(Book.last.cover_image).not_to be nil
        end
      end
    end

    context 'when file has improper format' do
      subject do
        post :create, params: {
          book: {
            title: 'Book with cover',
            description: 'Great book',
            author_id: author.id,
            cover_image: invalid_cover_image
          }
        }
      end

      it 'does not creates a book' do
        expect { subject }.not_to change(Book, :count)
      end
    end

    context 'when creating book with published date' do
      context 'when published date has proper format' do
        subject do
          post :create, params: {
            book: {
              title: 'Book with published date',
              description: 'Great book',
              author_id: author.id,
              published_at: '2018-07-12'
            }
          }
        end

        it 'creates a book' do
          expect { subject }.to change(Book, :count).by(1)
        end

        it 'book has published date' do
          subject
          expect(Book.last.published_at).not_to be nil
        end
      end

      context 'when published date has invalid format' do
        subject do
          post :create, params: {
            book: {
              title: 'Book with published date',
              description: 'Great book',
              author_id: author.id,
              published_at: 'random_string'
            }
          }
        end

        it 'creates a book' do
          expect { subject }.to change(Book, :count).by(1)
        end

        it 'book has not published date' do
          subject
          expect(Book.last.published_at).to be nil
        end
      end
    end
  end
end
