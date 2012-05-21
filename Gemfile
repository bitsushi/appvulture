source 'https://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem 'pg'

gem 'mailman', require: false
gem 'dkim'
gem "aws-ses", "~> 0.4.4", :require => 'aws/ses'
gem 'annotate', :git => 'git://github.com/ctran/annotate_models.git'
gem 'kaminari'
gem "ransack"
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'database_cleaner'
gem 'jquery-rails'
gem 'bcrypt-ruby'
gem 'state_machine'
gem 'vcr'
gem 'fakeweb'
gem 'bourbon'
gem 'timecop'
gem 'nokogiri'

group :test, :development do
  gem 'rspec-rails'
  gem "shoulda-matchers"
  gem "factory_girl_rails"
end

group :test do
gem 'simplecov', :require => false
  gem "capybara"
  gem "guard-rspec"
end
