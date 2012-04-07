class HomeController < ApplicationController
  def index
    @membre = Membre.new
    @nbre_vanneurs = Membre.count
    @nbre_vannes_postees = Vanne.where("valide=?",true).count
  end
end
