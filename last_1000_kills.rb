#! /usr/bin/env ruby

require 'fileutils'

ENV["DATE"] = ENV["DATE"] || Time.now.strftime("%Y%m%d%H%M%S")

abort("ERROR To run: #{__FILE__} <corporation_id> and <corporation_name>") if ARGV.size < 2
corporation_id   = ARGV[0]
corporation_name = ARGV[1]

files = []
(ENV["NUM"] || 5).to_i.times do |i|
  files << `./download.rb #{corporation_id} #{i}`.chomp
end

csv = `./make_csv.rb #{files.join(" ")}`.chomp

FileUtils.mkdir_p("reports")
`Rscript generate_pdf.R #{corporation_id} #{corporation_name}`
puts "IGNORE THE WARNING"
puts "\nReport: reports/#{corporation_name}-#{corporation_id}.pdf"
