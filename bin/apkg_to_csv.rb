#!/usr/bin/env ruby

require 'sqlite3'
require 'zip'
require 'tempfile'
require_relative '../lib/apkg_to_csv'

filename = ARGV[0]

if !filename
  puts 'Filename required'
  exit 1
end

file_written = false
tempfile = Tempfile.new('db')

Zip::File.open(filename) do |zip_file|
  zip_file.each do |entry|
    if entry.name == 'collection.anki2'
      tempfile.write(entry.get_input_stream.read)
      file_written = true
    end
  end
end

if !file_written
  puts 'Could not extract zip file correctly'
  exit 1
end

db = SQLite3::Database.new(tempfile.path)

puts ApkgToCsv.csv(db).csv
