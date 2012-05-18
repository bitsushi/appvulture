ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  def login! _user = nil
    user = _user || FactoryGirl.create(:user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Login'
  end

  def select_second_option(id)
    second_option_xpath = "//*[@id='#{id}']/option[2]"
    second_option = find(:xpath, second_option_xpath).text
    select(second_option, :from => id)
  end


  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.include(MailerMacros)
  config.before(:each) { reset_email }
end
