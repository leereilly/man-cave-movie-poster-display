require 'nokogiri'
require 'open-uri'

def download_image(url, dest)
  open(url) do |u|
    File.open(dest, 'wb') { |f| f.write(u.read) }
  end
end

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
  if (poster.include? 'thumb') && (poster.include? 'poster')
    image_url = 'https://www.joblo.com/' + poster.gsub("_thumb", "")
    filename = "posters/" + File.basename(image_url)

    open(filename, 'wb') do |file|
        puts "Writing #{image_url} to #{filename}"
        file << open(image_url).read
      end
  end
end
