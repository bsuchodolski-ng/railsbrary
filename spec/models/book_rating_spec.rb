require 'rails_helper'

RSpec.describe BookRating, type: :model do
  it { is_expected.to validate_presence_of(:user_id) }
  it { is_expected.to validate_presence_of(:book_id) }
  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_inclusion_of(:rating).in_range(1..5) }
  # it { is_expected.to validate_uniqueness_of(:book_id).scoped_to(:user_id) }
  it { is_expected.to belong_to(:book) }
  it { is_expected.to belong_to(:user) }
end
