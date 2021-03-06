class HomeController < ApplicationController
  skip_before_filter :require_login, :require_admin
  
  def index
    @titre = "Bienvenue"
    
    @membre = Membre.new
    
    @nbre_vanneurs = Membre.count
    @nbre_vannes_postees = Vanne.where("valide=?",true).count
    
    @direct_vannes = Vanne.where("valide=?",true).order("created_at DESC").limit(7)
    @lol_vannes = Vanne.where("valide=?",true).order("lols_count DESC, created_at DESC").limit(7)
    
    vannes_ids = Vanne.where("valide=?",true).select("id").map( &:id )
    @random_vannes = Vanne.find( (1..7).map { vannes_ids.delete_at( vannes_ids.size * rand ) } )
    
    @vip_vanneurs = Membre.order("lols_count * vannes_count DESC").limit(10)
  end
end
