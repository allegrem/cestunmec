class HomeController < ApplicationController
  def index
    @membre = Membre.new
  end
end
