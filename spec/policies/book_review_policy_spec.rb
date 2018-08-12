require 'rails_helper'

RSpec.describe BookReviewPolicy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  subject { described_class }


  permissions :new?, :create?, :edit?, :update?, :destroy? do
    it 'denies access to not owned book review' do
      expect(subject).not_to permit(user, BookReview.new(user_id: other_user.id))
    end
  end
end
