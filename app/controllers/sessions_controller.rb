class SessionsController < ApplicationController
  skip_before_filter :require_login, :require_admin
  
  
  def new
  end

  def create
    if membre = Membre.authenticate(params[:pseudo], params[:passwd])
      session[:membre_id] = membre.id
      redirect_to root_url, :notice => "Salut "+membre.pseudo+" ! Une nouvelle vanne ?"
    else
      redirect_to login_url, :alert => "Whoops ! Le pseudo et le mot de passe entres ne correspondent pas !"
    end
  end

  def destroy
    session[:membre_id] = nil
    redirect_to root_url, :notice => "Au revoir ;)"
  end
end
