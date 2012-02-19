class AddValideToVannes < ActiveRecord::Migration
  def up
    add_column :vannes, :valide, :boolean, :default => "false"
    
    Vanne.all.each do |v|
      v.valide = true
      v.save
    end
  end
  
  def down
    remove_column :vannes, :valide
  end
end
