class VannesController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]
  skip_before_filter :require_admin, :only => [:index, :show, :create, :new, :destroy]
  
  
  # GET /vannes
  # GET /vannes.rss
  # GET /vannes.js
  def index
    @vannes = Vanne.where('valide = ?',true)
    
    @step_lolitude = (Vanne.order('lols_count DESC').first.lols_count / 8).floor
    
    if params[:q] && params[:q] != ""
      @vannes = @vannes.where('LOWER(contenu) LIKE ?','%'+params[:q].downcase+'%')
    end
    
    if params[:ultimate] == "1"
      @vannes = @vannes.where('ultimate = ?',true)
    end
    
    case params[:lolitude]
      when '0'
	@vannes = @vannes.where('lols_count < ?', @step_lolitude)
      when '1'
	@vannes = @vannes.where(:lols_count => @step_lolitude..2*@step_lolitude)
      when '2'
	@vannes = @vannes.where(:lols_count => 2*@step_lolitude..3*@step_lolitude)
      when '3'
	@vannes = @vannes.where(:lols_count => 3*@step_lolitude..4*@step_lolitude)
      when '4'
	@vannes = @vannes.where(:lols_count => 4*@step_lolitude..5*@step_lolitude)
      when '5'
	@vannes = @vannes.where('lols_count > ?', 5*@step_lolitude)
    end
    
    case params[:order]
      when 'best'
	@vannes = @vannes.order('lols_count DESC, created_at DESC').limit(20).offset(20*params[:page].to_i)
	@titre = "Les meilleures vannes"
	
      when 'rand'
	vannes_ids = @vannes.select('id').map( &:id )
	@vannes = Vanne.find( (1..20).map { vannes_ids.delete_at( vannes_ids.size * rand ) } )
	@titre = "Des vannes au hasard"
	
      else
	@vannes = @vannes.order('created_at DESC').limit(20).offset(20*params[:page].to_i)
	@titre = "Les dernieres vannes"
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
    @titre = @vanne.membre.pseudo + " : " + @vanne.contenu[0..50] + "..."
    unless @vanne.valide
      redirect_to vannes_path, :error => "Cette vanne n'existe pas !"
    end
  end

  
  # GET /vannes/new
  def new
    @titre = "Poste ta vanne"
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
      @vannes = Vanne.where(:valide => false).order("updated_at")
    end
  end
  
end
