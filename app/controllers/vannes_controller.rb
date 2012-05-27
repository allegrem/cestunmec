class VannesController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]
  skip_before_filter :require_admin, :only => [:index, :show, :create, :new, :destroy]
  
  
  # GET /vannes
  # GET /vannes.rss
  # GET /vannes.js
  def index
    @vannes = Vanne.where('valide = ?',true)
    
    case params[:order]
      when 'best'
	@vannes = @vannes.order('lols_count DESC, created_at DESC').limit(20).offset(20*params[:page].to_i)
	
      when 'rand'
	vannes_ids = @vannes.select('id').map( &:id )
	@vannes = Vanne.find( (1..20).map { vannes_ids.delete_at( vannes_ids.size * rand ) } )
      
      else
	@vannes = @vannes.order('created_at DESC').limit(20).offset(20*params[:page].to_i)
    end
    
    if params[:q] && params[:q] != ""
      @vannes = @vannes.where('LOWER(contenu) LIKE ?','%'+params[:q].downcase+'%')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.rss { render :layout => false }
      format.js
    end
  end

  
  # GET /vannes/1
  def show
    @vanne = Vanne.find(params[:id])
    unless @vanne.valide
      redirect_to vannes_path, :error => "Cette vanne n'existe pas !"
    end
  end

  
  # GET /vannes/new
  def new
    @vanne = Vanne.new
  end

  
  # GET /vannes/1/edit
  def edit
    @vanne = Vanne.find(params[:id])
  end

  
  # POST /vannes
  def create
    @vanne = @current_membre.vannes.build(params[:vanne])
    
    if @vanne.save
      redirect_to vannes_path, :notice => 'Yeah !! Une nouvelle vanne ! Elle sera publiee une fois validee par nos soins.'
    else
      render :action => "new", :alert => 'Whoops ! Il y a eu une petite erreur !'
    end
  end

  
  # PUT /vannes/1
  def update
    @vanne = Vanne.find(params[:id])
    
    if params[:valide] == "yes"
      @vanne.valide = true
      @vanne.save
      redirect_to vannes_path(:order => 'validation'), :notice => "Vanne validee !"
    else
      if @vanne.update_attributes(params[:vanne])
	redirect_to @vanne, :notice => 'Vanne mise a jour !!' 
      else
	render :action => "edit", :alert => 'Whoops ! Il y a eu une petite erreur !' 
      end
    end
  end

  
  # DELETE /vannes/1
  def destroy
    @vanne = Vanne.find(params[:id])
    if @vanne.membre == @current_membre  ||  @current_membre.admin
      @vanne.destroy
      redirect_to vannes_path, :notice => "Snif ... Une vanne de moins :(" 
    else
      redirect_to root_path, :alert => "Qu'est ce que tu as essaye de faire ??"
    end
  end
  
  
  # GET /vannes/validation
  # POST /vannes/:id/validation
  def validation
    if params[:vanne_id]
      @vanne = Vanne.find(params[:vanne_id])
      if @vanne.update_attributes(:valide => true, :ultimate => params[:ultimate] || false)
	redirect_to validation_vannes_path, :notice => "Vanne validee !"
      else
	redirect_to validation_vannes_path, :alert => "Erreur lors de la validation de la vanne"
      end
      
    else
      @vannes = Vanne.where(:valide => false)
    end
  end
  
end
