# == Schema Information
#
# Table name: changes
#
#  id     :integer         not null, primary key
#  app_id :integer
#  price  :decimal(6, 2)   default(0.0)
#  at     :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :change do
    association :app
    price 20
    at { Time.now }
  end
end
