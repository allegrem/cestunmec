class ApplicationController < ActionController::Base
  before_filter :auto_login, :get_membre, :require_login, :require_admin
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
  
  def auto_login
    if @current_membre.nil? && cookies[:secret] && cookies[:membre_id] 
      membre = Membre.find(cookies[:membre_id])
      if membre && membre.cookie == cookies[:secret]
	session[:membre_id] = membre.id
	regenerate_cookie(membre)
      end
    end
  end
  
  def regenerate_cookie(membre)
    cookies[:membre_id] = membre.id
    cookies[:secret] = (0...20).map{65.+(rand(25)).chr}.join
    membre.update_attribute(:cookie, cookies[:secret])
  end
end
