class Vanne < ActiveRecord::Base
  belongs_to :membre
  has_many :lols, :dependent => :destroy
  
  validates_presence_of :contenu, :message => "Une vanne vide n'est pas une vanne !"
  validates_uniqueness_of :contenu, :message => "Incroyable !! Quelqu'un a déjà posté exactement la même vanne !"
  validates_format_of :contenu, :with => /C'est .+ s'appelle .+ c'est .+ !!/, :message => "Je crois que tu n'as pas bien compris comment rédiger une bonne vanne ... Elle doit commencer par « C'est ... » et finir par deux points d'exclamation (oui oui, deux points d'exclamation, c'est très important pour la vanne !). N'hésite pas à aller lire quelques conseils pour rédiger une bonne vanne en cliquant sur 'Le site' tout en bas à droite de la page."
  validates_length_of :contenu, :maximum => 140, :message => "Comment as-tu pu écrire une vanne drôle de plus de 140 caractères ??"
end
