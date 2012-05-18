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

class Lens < ActiveRecord::Base
  attr_accessible :desired_price, :initial_price, :app_id, :rule
  belongs_to :app
  belongs_to :watcher, class_name: 'User'
  validates_presence_of :initial_price, :desired_price, :watcher, :app, :rule
  # validates_numericality_of :desired_price#, greater_than: :initial_price, allow_nil: true
  validates :desired_price, numericality: true, desired_price: true
  validates_uniqueness_of :app_id, scope: :watcher_id
  validates_numericality_of :initial_price
  validates_numericality_of :rule

  before_create do
    self.initial_price = app.price
  end
end

