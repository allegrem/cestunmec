class CreateMembres < ActiveRecord::Migration
  def change
    create_table :membres do |t|
      t.string :pseudo
      t.string :hashed_passwd
      t.string :salt
      t.string :email

      t.timestamps
    end
  end
end
