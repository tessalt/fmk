class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :value
      t.references :character, foreign_key: true
      t.timestamps
    end
  end
end
