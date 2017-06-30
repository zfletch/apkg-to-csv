require 'json'
require 'sqlite3'

module ApkgToCsv
  class Model
    def self.from_db(db)
      db.execute('SELECT models FROM col').flat_map do |row|
        from_row(row)
      end
    end

    def self.from_row(row)
      row.flat_map do |models_json|
        JSON.parse(models_json).map { |k, v| new(k, v) }
      end
    end

    attr_reader :id

    def initialize(id, model_hash)
      @id = id.to_s
      @model_hash = model_hash
    end

    def fields
      @fields ||= model_hash["flds"].map { |f| f["name"] }
    end

    private

    attr_reader :model_hash
  end
end
