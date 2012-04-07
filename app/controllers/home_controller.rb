class HomeController < ApplicationController
  def index
    @membre = Membre.new
    
    @nbre_vanneurs = Membre.count
    @nbre_vannes_postees = Vanne.where("valide=?",true).count
    
    @direct_vannes = Vanne.where("valide=?",true).order("created_at DESC").limit(10)
    @lol_vannes = Vanne.where("valide=?",true).order("lols_count DESC, created_at DESC").limit(10)
  end
end
