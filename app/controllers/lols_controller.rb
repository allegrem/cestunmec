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
    if @current_membre.nil?  ||  Vanne.find(params[:vanne_id]).lols.where("membre_id = ?",@current_membre.id).count.zero?
      @lol = Lol.new(params[:lol])
      @lol.membre_id = @current_membre  if @current_membre
      @lol.vanne_id = params[:vanne_id]  if params[:vanne_id]
      
      @lol.vanne.lols_count += 1

      respond_to do |format|
	if @lol.save  &&  @lol.vanne.save
	  format.html { redirect_to vanne_path(@lol.vanne) }
	  format.json { render :json => @lol, :status => :created, :location => @lol }
	else
	  format.html { redirect_to @lol.vanne }
	  format.json { render :json => @lol.errors, :status => :unprocessable_entity }
	end
      end
    else
      respond_to do |format|
	format.html { redirect_to @lol.vanne }
	format.json { render :json => @lol.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  # DELETE /lols/1
  # DELETE /lols/1.json
  def destroy
    @lol = Lol.find(params[:id])
    
    @lol.vanne.lols_count -= 1
    @lol.vanne.save
    
    @lol.destroy

    respond_to do |format|
      format.html { redirect_to @lol.vanne }
      format.json { head :no_content }
    end
  end
end
