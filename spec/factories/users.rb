# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(100)
#  password_digest        :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  state                  :string(20)
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "rabbit#{n}@acme.com" }
    password "whatsupdoc"
    first_name "Bugs"
    last_name "Bunny"
  end
end
