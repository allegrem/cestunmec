class Vanne < ActiveRecord::Base
  belongs_to :membre
  has_many :lols, :dependent => :destroy
  
  validates_presence_of :contenu, :message => "Une vanne vide n'est pas une vanne !"
  validates_uniqueness_of :contenu, :message => "Incroyable !! Quelqu'un a deja poste exactement la meme vanne !"
  validates_format_of :contenu, :with => /C'est .+ s'appelle .+ c'est .+ !!/, :message => "Je crois que tu n'as pas bien compris comment rediger une bonne vanne ... Elle doit commencer par « C'est ... » et finir par deux points d'exclamation (oui oui, deux points d'exclamation, c'est tres important pour la vanne !). N'hesite pas a aller lire quelques conseils pour rediger une bonne vanne en cliquant sur 'Le site' tout en bas a droite de la page."
  validates_length_of :contenu, :maximum => 140, :message => "Comment as-tu pu ecrire une vanne drôle de plus de 140 caracteres ??"
end
