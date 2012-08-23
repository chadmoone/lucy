class PriceSnapshotsController < ApplicationController
  # GET /price_snapshots
  # GET /price_snapshots.json
  def index
    @price_snapshots = PriceSnapshot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @price_snapshots }
    end
  end

  # GET /price_snapshots/1
  # GET /price_snapshots/1.json
  def show
    @price_snapshot = PriceSnapshot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @price_snapshot }
    end
  end

  # GET /price_snapshots/new
  # GET /price_snapshots/new.json
  def new
    @price_snapshot = PriceSnapshot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @price_snapshot }
    end
  end

  # GET /price_snapshots/1/edit
  def edit
    @price_snapshot = PriceSnapshot.find(params[:id])
  end

  # POST /price_snapshots
  # POST /price_snapshots.json
  def create
    @price_snapshot = PriceSnapshot.new(params[:price_snapshot])
    
    respond_to do |format|
      if @price_snapshot.save
        format.html { redirect_to @price_snapshot, notice: 'Price snapshot was successfully created.' }
        format.json { render json: @price_snapshot, status: :created, location: @price_snapshot }
      else
        format.html { render action: "new" }
        format.json { render json: @price_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /price_snapshots/1
  # PUT /price_snapshots/1.json
  def update
    @price_snapshot = PriceSnapshot.find(params[:id])

    respond_to do |format|
      if @price_snapshot.update_attributes(params[:price_snapshot])
        format.html { redirect_to @price_snapshot, notice: 'Price snapshot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @price_snapshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_snapshots/1
  # DELETE /price_snapshots/1.json
  def destroy
    @price_snapshot = PriceSnapshot.find(params[:id])
    @price_snapshot.destroy

    respond_to do |format|
      format.html { redirect_to price_snapshots_url }
      format.json { head :no_content }
    end
  end
end
