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

class App < ActiveRecord::Base
  attr_accessible :currency, :mid, :name, :price#, :checked_at
  validates_presence_of :name, :mid, :price, :currency
  validates_numericality_of :price, :low, :high, :avg

  has_many :lenses, dependent: :destroy#, after_remove: :decrement_watcher_count
  # def decrement_watcher_count(record)
  #   p "REMOVING"
  #   App.decrement_counter(:watcher_count, id)
  # end
  has_many :changes
  has_many :watchers, through: :lenses, dependent: :destroy
  #, foreign_key: :watcher_id

  def to_param
    "#{id} #{name}".parameterize
  end

  def url
    "http://itunes.apple.com/gb/app/id#{mid}"
  end

  def to_s
    name
  end

  def price_is_now!(new_price)
    self.changes.build(price: new_price)
    self.save!
  end

  require 'json'
  require 'open-uri'

  def self.uber_find_or_create_by_mid(mid)
    unless app = App.limit(1).find_by_mid(mid)
      results = JSON.parse(open("http://itunes.apple.com/lookup?id=#{mid}&country=GB").read)
      results['results'].each do |r|
        app = App.create!({
          name: r['trackName'],
          mid: r['trackId'],
          price: r['price'],
          currency: r['currency']
        })
      end
    end
    return app
  end

  before_update do
    unless changes.empty?
      self.low = [low, changes.last.price].min
      self.high = [high, changes.last.price].max
      self.price = changes.last.price
    end
  end

  before_create do
    self.low = price
    self.high = price
  end

end
