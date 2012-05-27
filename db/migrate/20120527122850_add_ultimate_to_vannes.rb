class AddUltimateToVannes < ActiveRecord::Migration
  def change
    add_column :vannes, :ultimate, :boolean, :default => false

  end
end
