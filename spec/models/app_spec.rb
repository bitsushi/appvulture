# == Schema Information
#
# Table name: apps
#
#  id            :integer         not null, primary key
#  name          :string(50)
#  mid           :string(40)
#  price         :decimal(6, 2)   default(0.0)
#  currency      :string(3)       default("GBP")
#  high          :decimal(6, 2)   default(0.0)
#  low           :decimal(6, 2)   default(0.0)
#  avg           :decimal(6, 2)   default(0.0)
#  type          :string(7)
#  watcher_count :integer         default(0)
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe App do

  let(:app) { FactoryGirl.create(:app, price: 10) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:mid) }
  it { should have_many(:watchers) }
  it { should have_many(:changes) }

  pending "should update checked_at"

  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:low) }
  it { should validate_numericality_of(:high) }
  it { should validate_numericality_of(:avg) }
  it { should validate_presence_of(:currency) }

  it "should have 3 letter currency"
  it "should validate uniqueness of mid with scope of type"
  it "should record high"
  it "should record low"
  it "should calculate avg"

  it "should have parameterized url"
  #   app_path(app).should_not include("#{app.id} #{app.name}".parameterize)
  # end

  it "should set low and high on create" do
    app.low.should eq(app.price)
    app.high.should eq(app.price)
  end

  it "should set high if change is new high" do
    app.price.to_i.should eq(10)
    app.high.to_i.should eq(10)
    app.price_is_now!(30)
    app.price.to_i.should eq(30)
    app.high.to_i.should eq(30)
    app.price_is_now!(20)
    app.price.to_i.should eq(20)
    app.high.to_i.should eq(30)
  end

  it "should set low if change is new low" do
    app.price.to_i.should eq(10)
    app.low.to_i.should eq(10)
    app.price_is_now!(5)
    app.price.to_i.should eq(5)
    app.low.to_i.should eq(5)
    app.price_is_now!(7)
    app.price.to_i.should eq(7)
    app.low.to_i.should eq(5)
  end

end
