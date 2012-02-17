class VannesController < ApplicationController
  # GET /vannes
  # GET /vannes.json
  def index
    @vannes = Vanne.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @vannes }
    end
  end

  # GET /vannes/1
  # GET /vannes/1.json
  def show
    @vanne = Vanne.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @vanne }
    end
  end

  # GET /vannes/new
  # GET /vannes/new.json
  def new
    @vanne = Vanne.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @vanne }
    end
  end

  # GET /vannes/1/edit
  def edit
    @vanne = Vanne.find(params[:id])
  end

  # POST /vannes
  # POST /vannes.json
  def create
    @vanne = Vanne.new(params[:vanne])

    respond_to do |format|
      if @vanne.save
        format.html { redirect_to @vanne, :notice => 'Vanne was successfully created.' }
        format.json { render :json => @vanne, :status => :created, :location => @vanne }
      else
        format.html { render :action => "new" }
        format.json { render :json => @vanne.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /vannes/1
  # PUT /vannes/1.json
  def update
    @vanne = Vanne.find(params[:id])

    respond_to do |format|
      if @vanne.update_attributes(params[:vanne])
        format.html { redirect_to @vanne, :notice => 'Vanne was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @vanne.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /vannes/1
  # DELETE /vannes/1.json
  def destroy
    @vanne = Vanne.find(params[:id])
    @vanne.destroy

    respond_to do |format|
      format.html { redirect_to vannes_url }
      format.json { head :no_content }
    end
  end
end
