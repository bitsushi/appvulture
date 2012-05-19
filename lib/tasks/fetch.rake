require 'json'
require 'open-uri'

namespace :fetch do
  desc "From iTunes"

  task :itunes => :environment do
    results = JSON.parse(open("http://itunes.apple.com/search?term=a&country=GB&media=software&entity=software&limit=100").read)
    App.delete_all
    results['results'].each do |r|
      if app = App.find_by_mid(r['trackId'].to_s)
        if app.price.to_f != r['price'].to_f
          app.price_is_now! r['price']
          p "price change"
        else
          p 'no change'
        end
        # app.checked_at = Time.now
        app.save
      else
        # begin
          App.create!({
            name: r['trackName'],
            mid: r['trackId'],
            price: r['price'],
            currency: r['currency'],
            icon: r['artworkUrl60']
            # checked_at: Time.now
          })
        # rescue
        #   p "FAIL: #{r['trackName']}"
        # end
      end
    end
  end

  task :existing => :environment do
    App.limit(10).map(&:check_for_updates)
  end
end
