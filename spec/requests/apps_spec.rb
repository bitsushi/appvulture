require 'spec_helper'

describe "Apps" do
  # let(:app) { FactoryGirl.create(:app) }
  # it "should have parameterized url" do
  #   app_url(app.id).should_not include("#{app.id} #{app.name}".parameterize)
  # end

  it "should have index" do
    visit root_path
    click_link "Apps"
    current_path.should eq(apps_path)
    page.should have_content("Apps")
  end

  describe "show page" do

    # it "should not show user actions to unauthenticated users" do
    #   visit app_path(FactoryGirl.create(:app))
    #   page.should have_content('watch')
    # end

    it "should have show page" do
      app = FactoryGirl.create(:app, name: 'Angry Birds')
      visit root_path
      click_link "Apps"
      click_link 'Angry Birds'
      current_path.should eq( app_path(app) )
      page.should have_content("Angry Birds")
    end

    pending "should show prices" do
      app = FactoryGirl.create(:app, name: 'Angry Birds')
      visit(app_path(app))
      page.find('#current_price').text.to_i.should eq( price app.price)
    end

    it "should show changes" do
      app = FactoryGirl.create(:app, name: 'Angry Birds')
      app.price_is_now!(10)
      visit(app_path(app))
      page.should have_css('#changes')
    end

    it "should say if authenticated user has lens" do
      app = FactoryGirl.create(:app)
      user = FactoryGirl.create(:user)
      login! user
      user.apps << app
      visit app_path(app)
      page.should have_content('you are watching this app')
    end


    it "can stop watching inline" do
      app = FactoryGirl.create(:app)
      user = FactoryGirl.create(:user)
      login! user
      user.apps << app
      visit app_path(app)
      click_link 'stop watching'
      current_path.should eq(app_path(app))
      page.should have_content('Deleted Lens')
    end

    it "should be watchable" do
      app = FactoryGirl.create(:app)
      user = FactoryGirl.create(:user)
      login! user
      visit app_path(app)
      click_link 'watch this app'
      current_path.should eq( new_lens_path )
    end

  end
end
