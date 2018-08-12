require 'rails_helper'

RSpec.describe BookRatingPolicy do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  subject { described_class }

  permissions :create?, :update? do
    it 'denies access to not owned book rating' do
      expect(subject).not_to permit(user, BookRating.new(user_id: other_user.id))
    end
  end
end
