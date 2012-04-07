class AddLolsCountAndVannesCountToMembres < ActiveRecord::Migration
  def up
    add_column :membres, :lols_count, :integer
    add_column :membres, :vannes_count, :integer

    Membre.all.each do |m|
      m.vannes_count = Vanne.where("membre_id = ?", m.id).count
      m.lols_count = Vanne.where("membre_id = ?", m.id).sum(:lols_count)
      
      m.save(:validate => false)
    end
  end
  
  def down
    remove_column :membres, :lols_count
    remove_column :membres, :vannes_count
  end
end
