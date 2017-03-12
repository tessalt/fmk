require 'csv'

task import_characters: :environment do
  Vote.all.each {|v| v.destroy }
  Character.all.each {|c| c.destroy }
  csv = CSV.read(Rails.root.join('lib', 'assets', 'data.csv'))
  csv.shift
  csv.each do |row|
    Character.create(name: row[0], photo: row[1])
  end
end
