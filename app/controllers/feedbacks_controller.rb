class FeedbacksController < ApplicationController
  before_filter :authorize, :except => [:new, :create]
  
  
  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @feedbacks }
    end
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
    @feedback = Feedback.find(params[:id])
    
    unless @feedback.lu
      @feedback.lu = true
      @feedback.save
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @feedback }
    end
  end

  # GET /feedbacks/new
  # GET /feedbacks/new.json
  def new
    @feedback = Feedback.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @feedback }
    end
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(params[:feedback])
    if @current_membre
      @feedback.membre_id = @current_membre.id
    end

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to root_path, :notice => 'Votre message a bien ete enregistre. Nous allons essayer d\'y repondre des que possible.' }
        format.json { render :json => @feedback, :status => :created, :location => @feedback }
      else
        format.html { render :action => "new" }
        format.json { render :json => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /feedbacks/1
  # PUT /feedbacks/1.json
  def update
    @feedback = Feedback.find(params[:id])

    respond_to do |format|
      if @feedback.update_attribute(:lu, false)
        format.html { redirect_to feedbacks_path, :notice => 'Ce feedback a ete marque comme non lu.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @feedback.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback = Feedback.find(params[:id])
    @feedback.destroy

    respond_to do |format|
      format.html { redirect_to feedbacks_url }
      format.json { head :no_content }
    end
  end
  
  
  private
  
  def authorize
    unless @current_membre  &&  @current_membre.admin
      redirect_to root_path, :alert => "Qu'est-ce que tu as essayé de faire là ??"
    end
  end
end
