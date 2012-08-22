class DiamondsController < ApplicationController
  # GET /diamonds
  # GET /diamonds.json
  def index
    @diamonds = Diamond.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diamonds }
    end
  end

  # GET /diamonds/1
  # GET /diamonds/1.json
  def show
    @diamond = Diamond.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diamond }
    end
  end

  # GET /diamonds/new
  # GET /diamonds/new.json
  def new
    @diamond = Diamond.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diamond }
    end
  end

  # GET /diamonds/1/edit
  def edit
    @diamond = Diamond.find(params[:id])
  end

  # POST /diamonds
  # POST /diamonds.json
  def create
    @diamond = Diamond.new(params[:diamond])

    respond_to do |format|
      if @diamond.save
        format.html { redirect_to @diamond, notice: 'Diamond was successfully created.' }
        format.json { render json: @diamond, status: :created, location: @diamond }
      else
        format.html { render action: "new" }
        format.json { render json: @diamond.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diamonds/1
  # PUT /diamonds/1.json
  def update
    @diamond = Diamond.find(params[:id])

    respond_to do |format|
      if @diamond.update_attributes(params[:diamond])
        format.html { redirect_to @diamond, notice: 'Diamond was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diamond.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diamonds/1
  # DELETE /diamonds/1.json
  def destroy
    @diamond = Diamond.find(params[:id])
    @diamond.destroy

    respond_to do |format|
      format.html { redirect_to diamonds_url }
      format.json { head :no_content }
    end
  end
end
