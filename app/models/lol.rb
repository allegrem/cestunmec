class Lol < ActiveRecord::Base
  belongs_to :vanne
  belongs_to :membre
  
  validates :vanne_id, :presence => true
  validates :membre_id, :presence => true
end
