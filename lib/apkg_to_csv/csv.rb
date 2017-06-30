require 'csv'

module ApkgToCsv
  class Csv
    def self.from_notes(notes, models: [])
      csv_hash = {}

      models.each do |m|
        csv_hash[m.id] ||= []
        csv_hash[m.id] << m.fields
      end

      notes.each do |n|
        csv_hash[n.model_id] ||= []
        csv_hash[n.model_id] << n.fields
      end

      new(csv_hash)
    end

    attr_reader :csv

    def initialize(hash)
      @csv = CSV.generate do |csv|
        first, *rest = hash.values

        first.each { |f| csv << f }
        rest.each do |fields_array|
          csv << []
          fields_array.each { |f| csv << f }
        end
      end
    end
  end
end
