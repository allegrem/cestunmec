class MembresController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show, :new, :create]
  skip_before_filter :require_admin
  
  
  # GET /membres
  def index
    @membres = Membre.order("lols_count * vannes_count DESC")
  end

  
  # GET /membres/1
  def show
    @membre = Membre.find(params[:id])
    
    @vannes_best = @membre.vannes.where('valide = ?',true).order('lols_count DESC, created_at DESC').limit(10)
    @vannes_last = @membre.vannes.where('valide = ?',true).order('created_at DESC').limit(10)
    @lols = @membre.lols.limit(10)
  end

  
  # GET /membres/new
  def new
    @membre = Membre.new
  end

  
  # GET /membres/1/edit
  def edit
    @membre = Membre.find(params[:id])
    redirect_current_membre_or_admin
  end

  
  # POST /membres
  def create
    @membre = Membre.new(params[:membre])

    if @membre.save
      session[:membre_id] = @membre.id  #on connecte automatiquement
      redirect_to edit_membre_path(@membre), :notice => "Yeah !! Bienvenue dans la grande communaute de C'est un mec ! Tu peux des maintenant mettre a jour tes informations."
    else
      render :action => "new", :alert => "Whoops !! Il y a eu un petit probleme apparemment ..."
    end
  end

  
  # PUT /membres/1
  def update
    @membre = Membre.find(params[:id])
    redirect_current_membre_or_admin
    
    #changement de statut admin
    if params[:admin]  &&  @current_membre.admin?
      if @membre.update_attribute :admin, (params[:admin] == "yes" ? true : false)
	redirect_to @membre, :notice => "Changement du statut administrateur effectue"
      else
	redirect_to @membre, :notice => "Erreur lors du changement de statut administrateur"
      end
    
    #changement d'avatar
    elsif params[:avatar] && params[:avatar] != ""
      if params[:avatar] == 'twitter' || params[:avatar] == 'facebook'
	@membre.avatar = params[:avatar]
      else
	@membre.avatar = 'defaut'
      end
      if @membre.save
	redirect_to @membre, :notice => "Okay changements bien notes !"
      else
	render :action => "edit", :alert => "Whoops ! Il semblerait qu'il y ait eu un petit probleme"
      end
    
    #changements reseaux sociaux
    elsif params[:facebook] && params[:twitter]
      if @membre.update_attributes({:facebook => params[:facebook], :twitter => params[:twitter]})
	redirect_to @membre, :notice => "Okay changements bien notes !"
      else
	render :action => "edit", :alert => "Whoops ! Il semblerait qu'il y ait eu un petit probleme"
      end
    
    #edition normale
    elsif params[:membre]
      if @membre.update_attributes(params[:membre])
	redirect_to @membre, :notice => "Okay changements bien notes !"
      else
	render :action => "edit", :alert => "Whoops ! Il semblerait qu'il y ait eu un petit probleme"
      end
    end
  end
  

  # DELETE /membres/1
  def destroy
    @membre = Membre.find(params[:id])
    
    redirect_current_membre_or_admin
    
    @membre.destroy
    session[:membre_id] = nil  #on deconnecte
    redirect_to membres_url, :notice => "Noooooon !! Un membre de moins :("
  end
  
  
  
  private
  
  def redirect_current_membre_or_admin
    unless @membre == @current_membre  ||  @current_membre.admin?
      redirect_to root_url, :alert => "Qu'est ce que t'as essaye de faire la ?"
    end
  end
end
