require 'nokogiri'
require 'open-uri'

posters  = Array.new
url     = 'https://www.joblo.com/movie-posters'
doc     = Nokogiri::HTML(open(url))

posters = doc.css('img').map{ |i| i['src'] }

# Thumb pattern:
# https://www.joblo.com//assets/images/joblo/posters/2020/01/birdspreyhyenaman_thumb.jpg
#
# Full image pattern:
# https://www.joblo.com/assets/images/joblo/posters/2020/01/birdspreyhyenaman.jpg

posters.each do |poster|
  puts 'https://www.joblo.com/' + poster.gsub("_thumb", "") if poster.include? 'thumb'
end
