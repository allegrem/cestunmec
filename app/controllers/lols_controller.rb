class LolsController < ApplicationController
  def index
    @lols = Lol.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @lols }
    end
  end
  
  
  # POST /lols
  # POST /lols.json
  def create
    if @current_membre  &&  params[:vanne_id]  &&  Vanne.find(params[:vanne_id]).lols.where("membre_id = ?",@current_membre.id).count.zero?
      @lol = Lol.new(params[:lol])
      @lol.membre_id = @current_membre.id
      @lol.vanne_id = params[:vanne_id]
      
      respond_to do |format|
	if @lol.save
	  flash.now[:notice] = "Lol bien enregistre"
	  format.html { redirect_to vanne_path(@lol.vanne) }
	  format.js 
	  format.json { render :json => @lol, :status => :created, :location => @lol }
	else
	  format.html { redirect_to @lol.vanne, :alert => "Whoops ! Il y a eu un petit probleme !" }
	  format.json { render :json => @lol.errors, :status => :unprocessable_entity }
	end
      end
    else
      respond_to do |format|
	format.html { redirect_to vannes_path, :alert => "Whoops ! Il y a eu un petit probleme !" }
	format.json { render :json => @lol.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  # DELETE /lols/1
  # DELETE /lols/1.json
  def destroy
    @lol = Lol.find(params[:id])
    
    @lol.destroy

    respond_to do |format|
      format.html { redirect_to @lol.vanne, :notice => "Snif ... Un lol de moins :(" }
      format.js
      format.json { head :no_content }
    end
  end
end
