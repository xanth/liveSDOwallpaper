#!/usr/bin/env ruby
# Changes wallpaper to the most up to date SDO image; http://sdowww.lmsal.com/suntoday/#
require 'httparty'

def f(res)
  installLocation = File.dirname(File.expand_path $0)
  local_sun_file = "#{installLocation}/theSun.jpg"

  File.delete local_sun_file if File.exist? local_sun_file
    
  File.open(local_sun_file, "wb") do |io| 
    io.write res.parsed_response
  end
  
  # system "bash #{installLocation}/imageSet.sh #{installLocation}"
end



t = Time.now.utc

remote_sun_file = "http://sdowww.lmsal.com/sdomedia/SunInTime/#{t.year}/#{format('%.2d', t.month)}/#{format('%.2d', t.day)}/f_211_193_171.jpg"
respone = HTTParty.get(remote_sun_file);

case respone.code
when 200
  f(respone)
end
