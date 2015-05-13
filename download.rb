#! /usr/bin/env ruby

require 'httparty'
require 'fileutils'
require 'csv'

HEADERS = %w[id time attackers value]
TYPE = ENV["TYPE"] || "corporation"
date = ENV["DATE"] || Time.now.strftime("%Y%m%d%H%M%S")

if type_id = ARGV.first
  $stderr.puts "Fetching data for company: #{type_id}"
else
  abort "run: #{__FILE__} <type_id>"
end

page = ARGV[1] ? ARGV[1] : 1

response = HTTParty.get("https://zkillboard.com/api/#{TYPE}/#{type_id}/page/#{page}/", headers: {
  "Accept-Encoding" => "gzip",
  # "User-Agent" => "Resin Neublem resin.neublem@gmail.com"
})

FileUtils.mkdir_p("json")

if response.success?
  filename = "./json/#{TYPE}_#{type_id}_page_#{page}_#{date}.json"
  File.open(filename, "w") do |file|
    file << response.body
  end

  puts filename
else
  puts "Failure with the response: #{response.code}"
  p response
  abort
end
