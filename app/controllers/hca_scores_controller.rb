class HcaScoresController < ApplicationController
  # GET /hca_scores
  # GET /hca_scores.json
  def index
    @hca_scores = HcaScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hca_scores }
    end
  end

  # GET /hca_scores/1
  # GET /hca_scores/1.json
  def show
    @hca_score = HcaScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hca_score }
    end
  end

  # GET /hca_scores/new
  # GET /hca_scores/new.json
  def new
    @hca_score = HcaScore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hca_score }
    end
  end

  # GET /hca_scores/1/edit
  def edit
    @hca_score = HcaScore.find(params[:id])
  end

  # POST /hca_scores
  # POST /hca_scores.json
  def create
    @hca_score = HcaScore.new(params[:hca_score])

    respond_to do |format|
      if @hca_score.save
        format.html { redirect_to @hca_score, notice: 'Hca score was successfully created.' }
        format.json { render json: @hca_score, status: :created, location: @hca_score }
      else
        format.html { render action: "new" }
        format.json { render json: @hca_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hca_scores/1
  # PUT /hca_scores/1.json
  def update
    @hca_score = HcaScore.find(params[:id])

    respond_to do |format|
      if @hca_score.update_attributes(params[:hca_score])
        format.html { redirect_to @hca_score, notice: 'Hca score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hca_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hca_scores/1
  # DELETE /hca_scores/1.json
  def destroy
    @hca_score = HcaScore.find(params[:id])
    @hca_score.destroy

    respond_to do |format|
      format.html { redirect_to hca_scores_url }
      format.json { head :no_content }
    end
  end
end
