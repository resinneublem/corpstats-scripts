#! /usr/bin/env ruby

ENV["DATE"] = ENV["DATE"] || Time.now.strftime("%Y%m%d%H%M%S")
corporation_id = ARGV[0]

files = []
(ENV["NUM"] || 5).to_i.times do |i|
  files << `./download.rb #{corporation_id} #{i}`.chomp
end

puts `./make_csv.rb #{files.join(" ")}`
