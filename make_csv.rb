#! /usr/bin/env ruby

require 'httparty'
require 'fileutils'
require 'csv'
require 'json'

HEADERS = %w[id time attackers kill value]
TYPE = ENV["TYPE"] || "corporation"

kills = []
ARGV.each do |filename|
  kills += JSON.parse(File.read(filename))
end

csv_filename = "./csv/#{File.basename(ARGV[0], ".json")}.csv".gsub(/_page_\d+_\d+/, '')

type_id = ARGV[0].match(/#{TYPE}_(\d+)_/)[1]

CSV.open(csv_filename, "w", write_headers: true, headers: HEADERS) do |csv|
  kills.each do |data|
    was_a_kill = case TYPE
    when "corporation" then data["victim"]["corporationID"].to_s != type_id
    else true
    end
    csv << [data["killID"], data["killTime"], data["attackers"].size, was_a_kill ? 1 : 0, data["zkb"]["totalValue"]]
  end
end

puts csv_filename
