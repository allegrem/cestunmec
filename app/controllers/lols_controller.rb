class LolsController < ApplicationController
  skip_before_filter :require_admin

  
  # POST /lols
  def create
    @vanne = Vanne.find(params[:vanne_id])
    
    if @vanne  &&  @vanne.lols.where("membre_id = ?",@current_membre.id).count.zero?
      respond_to do |format|
	if @vanne.lols.create(:membre => @current_membre)
	  @vanne = Vanne.find(params[:vanne_id]) #on recharge l'objet car le nombre de lols a changé
	  flash.now[:notice] = "Lol bien enregistre"
	  format.html { redirect_to vanne_path(@vanne) }
	  format.js 
	else
	  format.html { redirect_to @vanne, :alert => "Whoops ! Il y a eu un petit probleme !" }
	end
      end
    
    else
      redirect_to vannes_path, :alert => "Whoops ! Il y a eu un petit probleme !"
    end
  end

  
  # DELETE /lols/1
  def destroy
    @lol = Lol.find(params[:id])
    @lol.destroy

    respond_to do |format|
      format.html { redirect_to @lol.vanne, :notice => "Snif ... Un lol de moins :(" }
      format.js
    end
  end
end
