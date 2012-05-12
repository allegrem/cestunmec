class FeedbacksController < ApplicationController
  skip_before_filter :require_login, :require_admin, :only => [:new, :create]
  
  
  # GET /feedbacks
  def index
    @feedbacks = Feedback.all
  end

  
  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end
  

  # POST /feedbacks
  def create
    @feedback = Feedback.new(params[:feedback])
    if @current_membre
      @feedback.membre_id = @current_membre.id
    end

    if @feedback.save
      redirect_to root_path, :notice => 'Votre message a bien ete enregistre. Nous allons essayer d\'y repondre des que possible.' 
    else
      render :action => "new" 
    end
  end
  

  # PUT /feedbacks/1
  def update
    @feedback = Feedback.find(params[:id])

    if @feedback.toggle! :lu
      redirect_to feedbacks_path, :notice => 'Ce feedback a ete marque comme lu / non lu.' 
    else
      render :action => "edit" 
    end
  end
  

  # DELETE /feedbacks/1
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    redirect_to feedbacks_url 
  end
  
end
