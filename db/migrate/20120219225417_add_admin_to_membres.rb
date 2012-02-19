class AddAdminToMembres < ActiveRecord::Migration
  def change
    add_column :membres, :admin, :boolean, :default => false

  end
end
