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

class Mac < App
  # attr_accessible :title, :body

  def url
    "http://itunes.apple.com/gb/app/id#{mid}"
  end
end
