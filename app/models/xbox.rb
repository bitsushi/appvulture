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

class Xbox < App

  require 'nokogiri'
  require 'open-uri'
  # attr_accessible :title, :body

  def self.uber_find_by_mid mid
    unless app = App.limit(1).find_by_mid(mid)
      url = "http://marketplace.xbox.com/en-US/Product/#{mid}"
      doc = Nokogiri::HTML(open(url))
      app = Xbox.new
      app.mid = mid
      app.currency = 'MSP'
      app.checked_at = Time.zone.now
      app.name = doc.css('h1').first.text
      app.icon = doc.css('.ProductBox.MediumDownloadType img').first.attributes['src'].value
      app.price = doc.css('#GetProduct .ProductPrices .SilverPrice.ProductPrice').text.to_i
      app.rating = 0
      doc.css(
        '#ProductTitleZone .UserRatingStarStrip .UserRating .Star').each do |star|
        app.rating += (star.attributes['class'].value.match(/Star(\d)/)[1].to_f)/4
      end
    else
      app.checked_at = Time.now
    end
    app.save!
    return app
  end
end
