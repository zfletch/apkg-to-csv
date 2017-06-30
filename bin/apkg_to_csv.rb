#!/usr/bin/env ruby

require 'sqlite3'
require './lib/apkg_to_csv'

filename = ARGV[0]

if !filename
  puts "Filename requires"
  exit 1
end

db = SQLite3::Database.new(filename)

puts ApkgToCsv.csv(db).csv
