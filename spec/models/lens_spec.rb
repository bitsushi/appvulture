# == Schema Information
#
# Table name: lenses
#
#  id            :integer         not null, primary key
#  watcher_id    :integer
#  app_id        :integer
#  rule          :integer(2)      default(0)
#  initial_price :decimal(6, 2)   default(0.0)
#  desired_price :decimal(6, 2)   default(0.0)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe Lens do
  it { should belong_to(:watcher) }
  it { should belong_to(:app) }
  it { should validate_presence_of(:watcher) }
  it { should validate_presence_of(:app) }
  it { should validate_numericality_of(:rule) }
  it { should validate_numericality_of(:desired_price) }
  it { should validate_numericality_of(:initial_price) }
  it { should validate_presence_of(:rule) }
  it "initial price should equal price of watched app" do
    app = FactoryGirl.create(:app, price: 50.00)
    user = FactoryGirl.create(:user)
    user.apps << app
    user.lenses.first.initial_price.should eq(app.price)
  end

  it "desired_price should be less app price" do
    app = FactoryGirl.build(:app, price: 10)
    FactoryGirl.build(:lens, app: app, desired_price: 99999).errors_on(:desired_price).should include('must be less than the app price')
    # app = FactoryGirl.build(:app, price: 0)
    # FactoryGirl.build(:lens, app: app, desired_price: 0).errors_on(:desired_price).should_not include('must be less than the app price')
  end

  it "should validate uniqueness of :app_id with the scope of :watcher_id" do
    user = FactoryGirl.create(:user)
    app = FactoryGirl.create(:app)
    user.apps << app
    lambda { user.apps << app }.should raise_exception(ActiveRecord::RecordInvalid)
  end
end
