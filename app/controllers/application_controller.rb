class ApplicationController < ActionController::Base
  before_filter :get_membre
  protect_from_forgery
  
  protected
  def get_membre
    if session[:membre_id]
      @membre = Membre.find(session[:membre_id])
    end
  end
end
