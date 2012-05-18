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

    it "should have show page" do
      app = FactoryGirl.create(:app, name: 'Angry Birds')
      visit root_path
      click_link "Apps"
      click_link 'Angry Birds'
      current_path.should eq( app_path(app) )
      page.should have_content("Angry Birds")
    end

    it "should show prices" do
      app = FactoryGirl.create(:app, name: 'Angry Birds')
      visit(app_path(app))
      page.find('#current_price').text.should eq(app.price.to_s)
    end

    it "should show changes" do
      app = FactoryGirl.create(:app, name: 'Angry Birds')
      app.price_is_now!(10)
      visit(app_path(app))
      page.should have_css('#changes')
    end

  end
end
