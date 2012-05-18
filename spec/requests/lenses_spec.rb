require 'spec_helper'

describe "Lenses" do

  it "should have index" do
    visit root_url
    page.should_not have_link("Lenses")
    login!
    click_link "Lenses"
    current_path.should eq( lenses_path )
  end

  it "can delete lens" do
    user = FactoryGirl.create(:user)
    user.apps << FactoryGirl.create(:app, name: 'killme')
    login! user
    click_link "Lenses"
    page.should have_link('killme')
    click_link 'delete'
    current_path.should eq(lenses_path)
    page.should have_content('Deleted Lens')
  end

  it "should be creatable" do
    FactoryGirl.create(:app)
    login!
    visit new_lens_path
    # select_second_option('lens_app_id')
    click_button 'Create Lens'
    page.should have_content('created lens')
  end

end
