require './lib/apkg_to_csv/model'
require './lib/apkg_to_csv/note'
require './lib/apkg_to_csv/csv'

module ApkgToCsv
  def self.csv(db)
    models = Model.from_db(db)
    notes = Note.from_db(db)

    Csv.from_notes(notes, models: models)
  end
end
