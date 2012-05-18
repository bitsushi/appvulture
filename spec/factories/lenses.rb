# == Schema Information
#
# Table name: lenses
#
#  id            :integer         not null, primary key
#  watcher_id    :integer
#  app_id        :integer
#  rule          :integer(1)      default(0)
#  initial_price :decimal(6, 2)   default(0.0)
#  desired_price :decimal(6, 2)   default(0.0)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lens do
    association :watcher, factory: :user
    association :app
    rule 1
    desired_price 0.50
  end
end
