# == Schema Information
#
# Table name: apps
#
#  id            :integer         not null, primary key
#  name          :string(100)
#  mid           :string(40)
#  price         :decimal(6, 2)   default(0.0)
#  currency      :string(3)
#  high          :decimal(6, 2)   default(0.0)
#  low           :decimal(6, 2)   default(0.0)
#  icon          :string(255)
#  type          :string(7)
#  watcher_count :integer         default(0)
#  rating        :decimal(4, 2)   default(0.0)
#  checked_at    :datetime
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

require 'spec_helper'

describe App do

  it "saves languages and/or territories"
  it "saves released date"
  it "saves updated date"
  it "has binary apps/games toggle"
  it "records number of reviews for popularity"


  let(:app) { FactoryGirl.create(:app, price: 10) }

  it { should validate_format_of(:icon).with('http://google.com/image.jpg')}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:mid) }
  it { should have_many(:watchers) }
  it { should have_many(:changes) }

  pending "should update checked_at"
  it "should set checked_at on create"
  it "should have to_be_checked scope"

  it { should validate_presence_of(:price) }
  it { should validate_numericality_of(:price) }
  it { should validate_numericality_of(:low) }
  it { should validate_numericality_of(:high) }
  # it { should validate_numericality_of(:avg) }
  it { should validate_presence_of(:currency) }

  it "should be searchable" do
    FactoryGirl.create(:app, name: 'Angry Birds')
    FactoryGirl.create(:app, name: 'Super Crate Box')
    FactoryGirl.create(:app, name: 'Super Meat Boy')
    App.text_search('super').size.should eq(2)
  end

  it { should validate_format_of(:currency).with('GBP') }

  it "should maintain watcher count" do
    app.watcher_count.should eq(0)
    user = FactoryGirl.create(:user)
    user.apps << app
    app.reload.watcher_count.should eq(1)
    user.apps.delete(app)
    app.reload.watcher_count.should eq(0)
  end

  it "should have uber_find_or_create_by_mid", :vcr do
    FactoryGirl.create(:app, mid: '99', name: 'angry birds')
    App.uber_find_or_create_by_mid('99').name.should eq('angry birds')
    App.uber_find_or_create_by_mid('520564038').name.should eq('Leonardo da Vinci: Anatomy')
  end

  it "should validate uniqueness of mid with scope of type" do
    FactoryGirl.create(:app, mid: '33')
    FactoryGirl.build(:app, mid: '33').should_not be_valid
  end

  # it "should calculate avg"

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
