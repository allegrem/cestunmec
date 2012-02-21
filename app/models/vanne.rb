class Vanne < ActiveRecord::Base
  belongs_to :membre
  has_many :lols, :dependent => :destroy
  
  validates :contenu, :presence => :true, :uniqueness => :true, :format => /C'est .+ s'appelle .+ c'est .+ !!/, :length => { :maximum => 140 }
end
