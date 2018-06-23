class SignInPage < SitePrism::Page
  set_url '/users/sign_in'

  element :email, '#user_email'
  element :password, '#user_password'
  element :remember_me, '#user_remember_me'
  element :submit_btn, '.actions > input[type="submit"]'
  element :sign_up_link, 'a[href="/users/sign_up"]'
  element :forgot_password_link, 'a[href="/users/password/new"]'

  def fill_in_form(email = nil, password = nil)
    self.email.set(email)
    self.password.set(password)
  end
end
