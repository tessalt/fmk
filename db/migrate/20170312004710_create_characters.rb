class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :photo
      t.text :description
      t.timestamps
    end
  end
end
