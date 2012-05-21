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

describe Xbox do

  it "should scan site", :vcr do
    Xbox.count.should eq(0)
    Xbox.scan_site
    Xbox.count.should eq(30)
  end

  it "should update by MID for existing game", :vcr, record: :new_episodes do
    Timecop.freeze(Time.now) do
      mid = '66acd000-77fe-1000-9115-d802584108b7'
      original_game = Xbox.uber_find_by_mid(mid)
      Timecop.travel(1.day)
      xbox_game = Xbox.uber_find_by_mid(mid)
      xbox_game.created_at.to_i.should eq( (Time.zone.now - 1.day).to_i )
      xbox_game.checked_at.to_i.should eq(Time.zone.now.to_i)
    end
  end

  it "should create by MID for priced game", :vcr, record: :new_episodes do
    Timecop.freeze(Time.now) do
      mid = '66acd000-77fe-1000-9115-d80258410a5a'
      xbox_game = Xbox.uber_find_by_mid(mid)
      xbox_game.mid.should eq(mid)
      xbox_game.price.should eq(1200)
      xbox_game.high.should eq(1200)
      xbox_game.low.should eq(1200)
      xbox_game.currency.should eq('MSP')
      xbox_game.name.should eq('Super Meat Boy')
      xbox_game.icon.should eq('http://download.xbox.com/content/images/66acd000-77fe-1000-9115-d80258410a5a/1033/boxartsm.jpg')
      xbox_game.checked_at.should eq(Time.now)
      xbox_game.created_at.should eq(Time.now)
      xbox_game.rating.to_f.should eq(4.25)
    end
  end

  it "should create by MID for free game", :vcr, record: :new_episodes do
    Timecop.freeze(Time.now) do
      mid = '66acd000-77fe-1000-9115-d8025841083c'
      xbox_game = Xbox.uber_find_by_mid(mid)
      xbox_game.mid.should eq(mid)
      xbox_game.price.should eq(0)
      xbox_game.high.should eq(0)
      xbox_game.low.should eq(0)
      xbox_game.currency.should eq('MSP')
      xbox_game.name.should eq('Aegis Wing')
      xbox_game.icon.should eq('http://mktplassets.xbox.com/NR/rdonlyres/7A4FBB69-6B9A-4EBE-B2BE-24648E07365F/0/boxaegiswing.jpg')
      xbox_game.checked_at.should eq(Time.now)
      xbox_game.created_at.should eq(Time.now)
      xbox_game.rating.to_f.should eq(4.0)
    end
  end
end
