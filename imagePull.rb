#!/usr/bin/env ruby
# Changes wallpaper to the most up to date SDO image; http://sdowww.lmsal.com/suntoday/#
require 'open-uri'

def internet?
  open('http://www.google.com/') ? true : false
end

if internet?
  t = Time.now.utc
  remote_sun_file = "http://sdowww.lmsal.com/sdomedia/SunInTime/#{t.year}/#{format('%.2d', t.month)}/#{format('%.2d', t.day)}/f_211_193_171.jpg"
  local_sun_file = 'theSun.jpg'
  File.delete local_sun_file if File.exist? local_sun_file
  open(local_sun_file, 'wb') { |file| file << open(remote_sun_file).read }
  system 'bash imageSet.sh'
end
