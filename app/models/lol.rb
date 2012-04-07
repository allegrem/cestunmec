class Lol < ActiveRecord::Base
  belongs_to :vanne
  belongs_to :membre
  
  
  validates :vanne_id, :presence => true
  validates :membre_id, :presence => true
  
  
  after_create :increase_lols_count
  before_destroy :decrease_lols_count

  
  protected
  
  def increase_lols_count
    Vanne.increment_counter(:lols_count, self.vanne_id)
    Membre.increment_counter(:lols_count, self.vanne.membre_id)
  end
  
  def decrease_lols_count
    Vanne.decrement_counter(:lols_count, self.vanne_id)
    Membre.decrement_counter(:lols_count, self.vanne.membre_id)
  end
end
