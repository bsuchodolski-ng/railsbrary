require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end
