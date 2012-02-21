class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :email
      t.text :message
      t.integer :membre_id
      t.boolean :lu, :default => false

      t.timestamps
    end
  end
end
