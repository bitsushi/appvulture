# == Schema Information
#
# Table name: changes
#
#  id     :integer         not null, primary key
#  app_id :integer
#  price  :decimal(6, 2)   default(0.0)
#  at     :datetime
#

require 'spec_helper'

describe Change do
  it { should belong_to(:app) }
  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it "datetime should be now on creation" do
    app = FactoryGirl.create(:app)
    app.price_is_now!(30.54)
    app.changes.first.at.should > (Time.now - 1.minute)
  end
end
