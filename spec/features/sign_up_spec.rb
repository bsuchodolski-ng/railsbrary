require 'rails_helper'

feature 'Sign up' do
  scenario 'with valid data' do
    visit '/users/sign_up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'First name', with: 'John'
    fill_in 'Last name', with: 'Doe'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
