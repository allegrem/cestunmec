class CreateLols < ActiveRecord::Migration
  def change
    create_table :lols do |t|
      t.integer :vanne_id
      t.integer :membre_id

      t.timestamps
    end
  end
end
