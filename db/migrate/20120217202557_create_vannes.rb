class CreateVannes < ActiveRecord::Migration
  def change
    create_table :vannes do |t|
      t.text :contenu
      t.integer :membre_id
      t.date :date

      t.timestamps
    end
  end
end
