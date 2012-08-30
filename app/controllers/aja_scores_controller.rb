class AjaScoresController < ApplicationController
  # GET /aja_scores
  # GET /aja_scores.json
  def index
    @aja_scores = AjaScore.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aja_scores }
    end
  end

  # GET /aja_scores/1
  # GET /aja_scores/1.json
  def show
    @aja_score = AjaScore.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aja_score }
    end
  end

  # GET /aja_scores/new
  # GET /aja_scores/new.json
  def new
    @aja_score = AjaScore.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aja_score }
    end
  end

  # GET /aja_scores/1/edit
  def edit
    @aja_score = AjaScore.find(params[:id])
  end

  # POST /aja_scores
  # POST /aja_scores.json
  def create
    @aja_score = AjaScore.new(params[:aja_score])

    respond_to do |format|
      if @aja_score.save
        format.html { redirect_to @aja_score, notice: 'Aja score was successfully created.' }
        format.json { render json: @aja_score, status: :created, location: @aja_score }
      else
        format.html { render action: "new" }
        format.json { render json: @aja_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /aja_scores/1
  # PUT /aja_scores/1.json
  def update
    @aja_score = AjaScore.find(params[:id])

    respond_to do |format|
      if @aja_score.update_attributes(params[:aja_score])
        format.html { redirect_to @aja_score, notice: 'Aja score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aja_score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aja_scores/1
  # DELETE /aja_scores/1.json
  def destroy
    @aja_score = AjaScore.find(params[:id])
    @aja_score.destroy

    respond_to do |format|
      format.html { redirect_to aja_scores_url }
      format.json { head :no_content }
    end
  end
end
