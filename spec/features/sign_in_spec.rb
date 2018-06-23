require 'rails_helper'
require 'support/pages/sign_in_page'

feature 'Sign in:' do
  let(:user) { create(:user) }
  let(:sign_in_page) { SignInPage.new }

  before do
    sign_in_page.load
  end

  context 'can log in with existing user with valid credentials' do
    scenario 'without remember me enabled' do
      sign_in_page.fill_in_form(user.email, user.password)
      sign_in_page.submit_btn.click
      expect(sign_in_page).to have_content 'Signed in successfully'
      expect(page.driver.request.cookies).not_to include('remember_user_token')
    end

    scenario 'with remember me enabled' do
      sign_in_page.fill_in_form(user.email, user.password)
      sign_in_page.remember_me.set(true)
      sign_in_page.submit_btn.click
      expect(sign_in_page).to have_content 'Signed in successfully'
      expect(page.driver.request.cookies).to include('remember_user_token')
    end

  end

  scenario 'can\'t log in with existing user with invalid credentials' do
    sign_in_page.fill_in_form(user.email, 'NotAValidPassword')
    sign_in_page.submit_btn.click
    expect(sign_in_page).to have_content 'Invalid Email or password'
  end

  scenario 'can\'t log in with non existing user' do
    sign_in_page.fill_in_form('idontexist@example.com', 'password')
    sign_in_page.submit_btn.click
    expect(sign_in_page).to have_content 'Invalid Email or password'
  end

  scenario 'can navigate to sign up page and reset password page' do
    expect(sign_in_page).to have_sign_up_link
    expect(sign_in_page).to have_forgot_password_link
  end
end
