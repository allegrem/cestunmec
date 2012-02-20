class RemoveDateFromVannes < ActiveRecord::Migration
  def up
    remove_column :vannes, :date
      end

  def down
    add_column :vannes, :date, :date
  end
end
