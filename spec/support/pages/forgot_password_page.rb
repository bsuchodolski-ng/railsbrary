class ForgotPasswordPage < SitePrism::Page
  set_url '/users/password/new'

  element :email, '#user_email'
  element :submit_btn, '.actions > input[type="submit"]'
  element :log_in_link, 'a[href="/users/sign_in"]'
  element :sign_up_link, 'a[href="/users/sign_up"]'
end
