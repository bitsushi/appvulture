require 'spec_helper'

describe "Users" do

  describe "viewing page" do

    it "should not show user nav if not logged in" do
      visit root_path
      page.should have_content("Signup")
      page.should have_content("Login")
      page.should_not have_content("Logout")
    end

    it "should show user nav if logged in" do
      login!
      visit root_path
      page.should_not have_content("Signup")
      page.should_not have_content("Login")
      page.should have_content("Logout")
    end

  end

  describe "signing up" do

    it "can signup with valid credentials" do
      visit root_path
      click_link "Signup"
      fill_in "Email", with: 'test@test.com'
      fill_in "Password", with: 'pass'
      fill_in "Password confirmation", with: 'pass'
      click_button "Signup"
      current_path.should eq(root_path)
      page.should have_content("You have signed up")
      last_email.to.should include('test@test.com')
    end

    it "cannot signup without valid credentials" do
      visit root_path
      click_link "Signup"
      fill_in "Email", with: 'testtest.com'
      fill_in "Password", with: 'pass'
      fill_in "Password confirmation", with: 'pass2'
      click_button "Signup"
      page.should have_content("Form is invalid")
    end

  end

  describe "logging in" do

    it "valid user can login" do
      user= FactoryGirl.create(:user, password: 'pass')
      visit root_path
      click_link "Login"
      fill_in "Email", with: user.email
      fill_in "Password", with: 'pass'
      click_button "Login"
      current_path.should eq(root_path)
      page.should have_content("Logged in")
    end

    it "valid user can login with uppercase email" do
      user= FactoryGirl.create(:user, password: 'pass')
      visit root_path
      click_link "Login"
      fill_in "Email", with: user.email.upcase
      fill_in "Password", with: 'pass'
      click_button "Login"
      current_path.should eq(root_path)
      page.should have_content("Logged in")
    end

    it "valid user cannot login with incorrect password" do
      user= FactoryGirl.create(:user, password: 'pass')
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: 'pass2'
      click_button "Login"
      page.should have_content("Email or password is invalid")
    end

    it "invalid user cannot login" do
      visit login_path
      fill_in "Email", with: 'fake@user.com'
      fill_in "Password", with: 'pass'
      click_button "Login"
      page.should have_content("Email or password is invalid")
    end

  end

  describe "logging out" do

    it "can logout" do
      login!
      click_link "Logout"
      page.should have_content("Logged out")
      page.should have_content("Login")
    end

  end

end
