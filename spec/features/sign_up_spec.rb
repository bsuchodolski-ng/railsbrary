require 'rails_helper'
require 'support/pages/sign_up_page'

feature 'Sign up' do
  let(:sign_up_page) { SignUpPage.new }

  before do
    sign_up_page.load
  end

  scenario 'with valid data' do
    sign_up_page.fill_in_form(
      'user@example.com',
      'John',
      'Doe',
      'password',
      'password'
    )
    sign_up_page.submit_btn.click
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'without required fields' do
    sign_up_page.fill_in_form(
      '',
      '',
      '',
      '',
      ''
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(page).to have_content 'Email can\'t be blank'
      expect(page).to have_content 'First name can\'t be blank'
      expect(page).to have_content 'Last name can\'t be blank'
      expect(page).to have_content 'Password can\'t be blank'
    end
  end

  scenario 'with invalid email' do
    sign_up_page.fill_in_form(
      'user.example.com',
      'John',
      'Doe',
      'password',
      'password'
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(page).to have_content 'Email is invalid'
    end
  end

  scenario 'with too short password' do
    sign_up_page.fill_in_form(
      'user@example.com',
      'John',
      'Doe',
      'pass',
      'pass'
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(page).to have_content 'Password is too short'
    end
  end

  scenario 'without password confirmation' do
    sign_up_page.fill_in_form(
      'user@example.com',
      'John',
      'Doe',
      'password',
      ''
    )
    sign_up_page.submit_btn.click
    within sign_up_page.error_explanation do
      expect(page)
        .to have_content 'Password confirmation doesn\'t match Password'
    end
  end
end
