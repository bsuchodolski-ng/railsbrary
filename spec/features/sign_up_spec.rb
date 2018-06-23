require 'rails_helper'
require 'support/pages/sign_up_page'

feature 'Sign up:' do
  let(:sign_up_page) { SignUpPage.new }
  let(:user) { create(:user) }

  before do
    sign_up_page.load
  end

  scenario 'can sign up with valid data' do
    sign_up_page.fill_in_form(
      'user@example.com',
      'John',
      'Doe',
      'password',
      'password'
    )
    sign_up_page.submit_btn.click
    expect(sign_up_page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'can\'t sign up without required fields' do
    sign_up_page.fill_in_form(
      '',
      '',
      '',
      '',
      ''
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(sign_up_page).to have_content 'Email can\'t be blank'
      expect(sign_up_page).to have_content 'First name can\'t be blank'
      expect(sign_up_page).to have_content 'Last name can\'t be blank'
      expect(sign_up_page).to have_content 'Password can\'t be blank'
    end
  end

  scenario 'can\'t sign up with invalid email' do
    sign_up_page.fill_in_form(
      'user.example.com',
      'John',
      'Doe',
      'password',
      'password'
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(sign_up_page).to have_content 'Email is invalid'
    end
  end

  context 'when there is existing user with the same email' do
    scenario 'can\'t sign up with the same email' do
      sign_up_page.fill_in_form(
        user.email,
        'John',
        'Doe',
        'password',
        'password'
      )
      sign_up_page.submit_btn.click
      within sign_up_page.error_explanation do
        expect(sign_up_page).to have_content 'Email has already been taken'
      end
    end
  end

  scenario 'can\'t sign up with too short password' do
    sign_up_page.fill_in_form(
      'user@example.com',
      'John',
      'Doe',
      'pass',
      'pass'
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(sign_up_page).to have_content 'Password is too short'
    end
  end

  scenario 'can\'t sign up without password confirmation' do
    sign_up_page.fill_in_form(
      'user@example.com',
      'John',
      'Doe',
      'password',
      ''
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(sign_up_page)
        .to have_content 'Password confirmation doesn\'t match Password'
    end
  end

  scenario 'can navigate to login page' do
    expect(sign_up_page).to have_log_in_link
  end
end
