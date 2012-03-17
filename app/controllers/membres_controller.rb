class MembresController < ApplicationController
  # GET /membres
  # GET /membres.json
  def index
    @membres = Membre.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @membres }
    end
  end

  # GET /membres/1
  # GET /membres/1.json
  def show
    @membre = Membre.find(params[:id])
    if @current_membre == @membre
      @vannes = @membre.vannes.order('created_at DESC')
    else
      @vannes = @membre.vannes.where('valide = ?',true).order('created_at DESC')
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @membre }
    end
  end

  # GET /membres/new
  # GET /membres/new.json
  def new
    @membre = Membre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @membre }
    end
  end

  # GET /membres/1/edit
  def edit
    @membre = Membre.find(params[:id])
    
    if not(@membre == @current_membre || @current_membre.admin?)
      redirect_to root_url, :alert => "Qu'est ce que t'as essaye de faire la ??"
    end
  end

  # POST /membres
  # POST /membres.json
  def create
    @membre = Membre.new(params[:membre])

    respond_to do |format|
      if @membre.save
	session[:membre_id] = @membre.id  #on connecte automatiquement
        format.html { redirect_to @membre, :notice => "Yeah !! Bienvenue dans la grande communaute de C'est un mec !" }
        format.json { render :json => @membre, :status => :created, :location => @membre }
      else
        format.html { render :action => "new", :alert => "Whoops !! Il y a eu un petit probleme apparemment ..." }
        format.json { render :json => @membre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /membres/1
  # PUT /membres/1.json
  def update
    @membre = Membre.find(params[:id])
    
    if params[:admin]  &&  @current_membre.admin?
      if @membre.update_attribute :admin, params[:admin] == "yes" ? true : false
	redirect_to @membre, :notice => "Changement du statut administrateur effectue"
      else
	redirect_to @membre, :notice => "Erreur lors du changement de statut administrateur"
      end
    else    
      if @membre == @current_membre  ||  @current_membre.admin?
	respond_to do |format|
	  if @membre.update_attributes(params[:membre])
	    format.html { redirect_to @membre, :notice => 'Okay changements bien notes !' }
	    format.json { head :no_content }
	  else
	    format.html { render :action => "edit", :alert => "Whoops ! Il semblerait qu'il y ait eu un petit probleme" }
	    format.json { render :json => @membre.errors, :status => :unprocessable_entity }
	  end
	end
      else
	redirect_to root_url, :alert => "Qu'est ce que t'as essaye de faire la ?"
      end
    end
  end

  # DELETE /membres/1
  # DELETE /membres/1.json
  def destroy
    @membre = Membre.find(params[:id])
    
    if @membre == @current_membre  ||  @current_membre.admin?
      @membre.destroy
      session[:membre_id] = nil  #on deconnecte

      respond_to do |format|
	format.html { redirect_to membres_url, :notice => "Noooooon !! Un membre de moins :(" }
	format.json { head :no_content }
      end
    else
      redirect_to root_url, :alert => "Qu'est ce que t'as essaye de faire la ?"
    end
  end
end
