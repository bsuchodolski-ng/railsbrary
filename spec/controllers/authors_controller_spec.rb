require 'rails_helper'

RSpec.describe AuthorsController, type: :controller do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe 'POST #create' do
    context 'when author has a valid name' do
      context 'and standard request is made' do
        subject { post :create, params: { author: { name: 'Mark Twain' } } }
        it 'creates an author' do
          expect { subject }.to change(Author, :count).by(1)
        end

        it 'returns author as json' do
          subject
          expect(response.body).to eq assigns[:author].to_json
        end
      end

      context 'and xhr request is made' do
        subject { post :create, xhr: true, params: { author: { name: 'Mark Twain' } } }
        it 'creates an author' do
          expect { subject }.to change(Author, :count).by(1)
        end

        it 'returns author as json' do
          subject
          expect(response.body).to eq assigns[:author].to_json
        end
      end
    end

    context 'when author has invalid name' do
      context 'and standard request is made' do
        subject { post :create, params: { author: { name: '' } } }
        it 'does not creates an author' do
          expect { subject }.not_to change(Author, :count)
        end

        it 'returns errors as json' do
          subject
          expect(response.body).to include('Name can\'t be blank')
        end
      end

      context 'and xhr request is made' do
        subject { post :create, xhr: true, params: { author: { name: '' } } }
        it 'does not creates an author' do
          expect { subject }.not_to change(Author, :count)
        end

        it 'returns errors as json' do
          subject
          expect(response.body).to include('Name can\'t be blank')
        end
      end
    end
  end
end
