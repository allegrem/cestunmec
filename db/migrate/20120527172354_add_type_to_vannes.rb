class AddTypeToVannes < ActiveRecord::Migration
  def change
    add_column :vannes, :type, :string

  end
end
