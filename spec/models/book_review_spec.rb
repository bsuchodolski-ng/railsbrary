require 'rails_helper'

RSpec.describe BookReview, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:book_id) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_uniqueness_of(:book_id)
    .scoped_to(:user_id).with_message("was already reviewed") }
  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:user) }
end
