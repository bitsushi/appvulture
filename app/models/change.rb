# == Schema Information
#
# Table name: changes
#
#  id     :integer         not null, primary key
#  app_id :integer
#  price  :decimal(6, 2)   default(0.0)
#  at     :datetime
#

class Change < ActiveRecord::Base
  attr_accessible :price
  belongs_to :app
  validates :price, numericality: true, presence: true

  before_create do
    self.at = Time.now
  end
end
