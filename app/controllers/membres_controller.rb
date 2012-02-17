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
  end

  # POST /membres
  # POST /membres.json
  def create
    @membre = Membre.new(params[:membre])

    respond_to do |format|
      if @membre.save
        format.html { redirect_to @membre, :notice => 'Membre was successfully created.' }
        format.json { render :json => @membre, :status => :created, :location => @membre }
      else
        format.html { render :action => "new" }
        format.json { render :json => @membre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /membres/1
  # PUT /membres/1.json
  def update
    @membre = Membre.find(params[:id])

    respond_to do |format|
      if @membre.update_attributes(params[:membre])
        format.html { redirect_to @membre, :notice => 'Membre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @membre.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /membres/1
  # DELETE /membres/1.json
  def destroy
    @membre = Membre.find(params[:id])
    @membre.destroy

    respond_to do |format|
      format.html { redirect_to membres_url }
      format.json { head :no_content }
    end
  end
end
