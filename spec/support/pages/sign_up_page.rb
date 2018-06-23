class SignUpPage < SitePrism::Page
  set_url '/users/sign_up'

  element :error_explanation, '#error_explanation'

  element :email, '#user_email'
  element :first_name, '#user_first_name'
  element :last_name, '#user_last_name'
  element :password, '#user_password'
  element :password_confirmation, '#user_password_confirmation'
  element :submit_btn, '.actions > input[type="submit"]'
  element :log_in_link, 'a[href="/users/sign_in"]'

  def fill_in_form(email = nil, first_name = nil,
                   last_name = nil, password = nil,
                   password_confirmation = nil)
    self.email.set(email)
    self.first_name.set(first_name)
    self.last_name.set(last_name)
    self.password.set(password)
    self.password_confirmation.set(password_confirmation)
  end
end
