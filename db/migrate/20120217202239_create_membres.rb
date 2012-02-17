class CreateMembres < ActiveRecord::Migration
  def change
    create_table :membres do |t|
      t.string :pseudo
      t.string :passwd

      t.timestamps
    end
  end
end
