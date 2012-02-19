class AddLolsCountToVannes < ActiveRecord::Migration
  def up
    add_column :vannes, :lols_count, :integer, :default => 0
    
    Vanne.all.each do |v|
      v.lols_count = v.lols.count
      v.save
    end
  end
  
  def down
    remove_column :vannes, :lols_count
  end
end
