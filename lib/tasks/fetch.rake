require 'json'
require 'open-uri'

namespace :fetch do
  desc "From iTunes"
  task :itunes => :environment do
    results = JSON.parse(open("http://itunes.apple.com/search?term=a&country=GB&media=software&entity=software&limit=100").read)
    App.delete_all
    results['results'].each do |r|
      App.create!({
        name: r['trackName'],
        mid: r['trackId'],
        price: r['price'],
        currency: r['currency']
      })
    end
  end
end
