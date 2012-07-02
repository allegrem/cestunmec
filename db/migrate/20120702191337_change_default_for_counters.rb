class ChangeDefaultForCounters < ActiveRecord::Migration
  def up
    change_column_default(:membres, :lols_count, 0)
    change_column_default(:membres, :vannes_count, 0)
    Membre.all.each do |m|
      m.update_attribute(:lols_count, 0)
      m.update_attribute(:vannes_count, 0)
      m.save(:validate => false)
    end
  end

  def down
    change_column_default(:membres, :lols_count, nil)
    change_column_default(:membres, :vannes_count, nil)
  end
end
