class AddCookieToMembre < ActiveRecord::Migration
  def change
    add_column :membres, :cookie, :string

  end
end
