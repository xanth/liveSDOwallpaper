#!/usr/bin/env ruby
# Changes wallpaper to the most up to date SDO image; http://sdowww.lmsal.com/suntoday/#
require 'open-uri'
require 'resolv-replace'
require 'ping'

def internet?
  Ping.pingecho "google.com", 1, 80
end

if internet?
	t = Time.now.utc

	begin
		File.delete('theSun.jpg')
	rescue
	
	end 

	open('theSun.jpg', 'wb') do |file|
  		file << open("http://sdowww.lmsal.com/sdomedia/SunInTime/#{t.year}/#{"%.2d" % t.month}/#{"%.2d" % t.day}/f_211_193_171.jpg").read
	end

	system( "bash imageSet.sh" )
