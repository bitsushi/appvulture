# require 'spec_helper'
#
# module UserMacros
#   def login!
#     user = FactoryGirl.create(:user)
#     visit login_path
#     fill_in 'Email', with: user.email
#     fill_in 'Password', with: user.password
#     click_button 'Login'
#   end
# end