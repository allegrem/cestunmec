class SessionsController < ApplicationController
  def new
    
  end

  def create
    if membre = Membre.authenticate(params[:pseudo], params[:passwd])
      session[:membre_id] = membre.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "Whoops ! Le pseudo et le mot de passe entrés ne correspondent pas !"
    end
  end

  def destroy
    session[:membre_id] = nil
    redirect_to root_url, :notice => "Vous êtes bien déconnecté."
  end
end
