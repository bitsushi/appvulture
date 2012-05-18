require 'json'
require 'open-uri'

namespace :fetch do
  desc "From iTunes"
  task :itunes => :environment do
    results = JSON.parse(open("http://itunes.apple.com/search?term=a&country=GB&media=software&entity=software&limit=100").read)
    App.delete_all
    results['results'].each do |r|

      if app = App.find_by_mid(r['trackId'])
        if app.price.to_f != r['price'].to_f
          app.price = r['price']
          p "price change"
        else
          app.checked_at = Time.now
          p 'no change'
        end
        app.save
      else
        App.create!({
          name: r['trackName'],
          mid: r['trackId'],
          price: r['price'],
          currency: r['currency']
        })
      end
    end
  end
end
