class AddFacebookTwitterToMembres < ActiveRecord::Migration
  def change
    add_column :membres, :facebook, :string

    add_column :membres, :twitter, :string

  end
end
