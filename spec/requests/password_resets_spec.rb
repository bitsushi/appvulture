require 'spec_helper'

describe "PasswordResets" do
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link "forgotten password"
    fill_in "Email", with: user.email
    click_button "Reset"
    current_path.should eq(root_path)
    page.should have_content("Email sent")
    last_email.to.should include(user.email)
  end

  it "does not email invalid user when requesting password reset" do
    visit login_path
    click_link "forgotten password"
    fill_in "Email", with: "fakeemail@email.com"
    click_button "Reset"
    current_path.should eq(password_resets_path)
    page.should have_content("User not found")
    last_email.should be_nil
  end

  it "updates the user password when confirmation matches" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "newpass"
    click_button "Update Password"
    page.should have_content("Password doesn't match confirmation")
    fill_in "Password", :with => "newpass"
    fill_in "Password confirmation", :with => "newpass"
    click_button "Update Password"
    page.should have_content("Password has been reset")
  end

  it "reports when password token has expired" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.day.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => "newpass"
    fill_in "Password confirmation", :with => "newpass"
    click_button "Update Password"
    page.should have_content("Password reset has expired")
  end

  it "does not allow a blank password" do
    user = FactoryGirl.create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.minute.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in "Password", :with => ""
    fill_in "Password confirmation", :with => ""
    click_button "Update Password"
    page.should_not have_content("Password has been reset")
  end

  it "raises record not found when password token is invalid" do
    lambda {
      visit edit_password_reset_path("invalid")
    }.should raise_exception(ActiveRecord::RecordNotFound)
  end

end
