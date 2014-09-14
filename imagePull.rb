#!/usr/bin/env ruby

require 'open-uri'

def main
  install_location = File.dirname(__FILE__)
  temp_sun_file = "#{install_location}/tempSun.jpg"
  local_sun_file = "#{install_location}/theSun.jpg"
  remote_sun_file = 'http://sdowww.lmsal.com/sdomedia/SunInTime/mostrecent/f_211_193_171.jpg'

  download_with_clobber(remote_sun_file, temp_sun_file)
rescue => exception
  output_error exception
  exit_with_failure
else
  rotate_files local_sun_file, temp_sun_file
  system "bash #{install_location}/imageSet.sh #{install_location}"
ensure
  delete temp_sun_file
end

def download_with_clobber(remote_source, local_destination)
  delete local_destination
  open(local_destination, 'wb') { |file| file << open(remote_source).read }
end

def rotate_files(old_file, new_file)
  backup_file = "#{old_file}.bak"
  rename old_file, backup_file
  rename new_file, old_file
rescue => exception
  output_error exception
  exit_with_failure
else
  delete backup_file
  delete new_file
end

def delete(file)
  File.delete file if File.exist? file
end

def rename(old, new)
  File.rename old, new if File.exist? old
end

def output_error(exception)
  $stderr.puts "\e[31mError:\e[0m #{exception.class} - #{exception.message}" if exception.is_a? Exception
end

def exit_with_failure
  exit false
end

main
