require 'rails_helper'
require 'support/pages/forgot_password_page'

feature 'Forgot password:' do
  let(:user) { create(:user) }
  let(:forgot_password_page) { ForgotPasswordPage.new }

  before do
    forgot_password_page.load
  end

  scenario 'can reset password with existing user' do
    forgot_password_page.email.set(user.email)
    expect { forgot_password_page.submit_btn.click }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    expect(forgot_password_page)
      .to have_content I18n.t('devise.passwords.send_paranoid_instructions')
  end

  scenario 'it does not reveal if user doesn\'t exist' do
    forgot_password_page.email.set('nonexistent@example.com')
    expect { forgot_password_page.submit_btn.click }
      .not_to change { ActionMailer::Base.deliveries.count }
    expect(forgot_password_page)
      .to have_content I18n.t('devise.passwords.send_paranoid_instructions')
  end

end
