require 'json'
require 'open-uri'

namespace :fetch do
  desc "From iTunes"

  task :itunes => :environment do
    results = JSON.parse(open("http://itunes.apple.com/search?term=a&country=GB&media=software&entity=software&limit=100").read)
    Ios.delete_all
    results['results'].each do |r|
      if app = Ios.find_by_mid(r['trackId'].to_s)
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
          Ios.create!({
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


  task :mac => :environment do
    results = JSON.parse(open("http://itunes.apple.com/search?term=c&country=GB&media=software&entity=macSoftware&limit=100").read)
    Mac.delete_all
    results['results'].each do |r|
      if app = Mac.find_by_mid(r['trackId'].to_s)
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
          Mac.create!({
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

  # task :android
  # https://play.google.com/store/apps/details?id=com.cellfish.livewallpaper.marvel_avengers

  task :existing => :environment do
    Ios.limit(10).map(&:check_for_updates)
  end
end
