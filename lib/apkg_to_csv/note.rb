module ApkgToCsv
  class Note
    def self.from_db(db)
      db.execute("SELECT mid, flds FROM notes").map do |model_id, field_string|
        new(model_id, field_string)
      end
    end

    attr_reader :model_id

    def initialize(model_id, field_string)
      @model_id = model_id.to_s
      @field_string = field_string
    end

    def fields
      @fields ||= field_string.split("\x1f")
    end

    private

    attr_reader :field_string
  end
end
