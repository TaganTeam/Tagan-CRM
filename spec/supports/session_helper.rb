def sign_up
  visit login_path

  fill_in :email, :with => 'qq@ww.com'
  fill_in :password, :with => 'password'


  click_button 'login'
end