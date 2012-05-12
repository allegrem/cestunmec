class ApplicationController < ActionController::Base
  before_filter :get_membre, :require_login, :require_admin
  protect_from_forgery
  
  protected
  def get_membre
    if session[:membre_id]
      @current_membre = Membre.find(session[:membre_id])
    end
  end
  
  def require_login
    if @current_membre.nil?
      flash[:error] = "Vous devez etre connecte pour afficher cette page"
      redirect_to login_path
    end
  end
  
  def require_admin
    unless @current_membre.admin
      flash[:error] = "Vous devez etre admin pour afficher cette page"
      redirect_to root_path
    end
  end
end
