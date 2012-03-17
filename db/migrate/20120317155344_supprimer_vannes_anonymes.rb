class SupprimerVannesAnonymes < ActiveRecord::Migration
  def up
    m = Membre.new :pseudo => "Anonymous"
    m.save(:validate => false)
    Vanne.where("membre_id IS NULL").each do |v|
      v.update_attribute :membre_id, m.id
    end
  end

  def down
    m = Membre.where("pseudo = 'Anonymous'").first
    m.vannes.each do |v|
      v.update_attribute :membre_id, nil
    end
    m.destroy
  end
end
