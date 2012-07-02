class AddAvatarToMembre < ActiveRecord::Migration
  def change
    add_column :membres, :avatar, :string, :default => 'defaut'

  end
end
