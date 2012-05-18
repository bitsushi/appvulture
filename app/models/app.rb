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
  attr_accessible :currency, :mid, :name, :price
  validates_presence_of :name, :mid, :price, :currency
  validates_numericality_of :price, :low, :high, :avg

  has_many :changes

  def to_param
    "#{id} #{name}".parameterize
  end

  def to_s
    name
  end

  def price_is_now!(new_price)
    self.changes.build(price: new_price)
    self.save!
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
