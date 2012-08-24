class DiamondsController < ApplicationController
  # GET /diamonds
  # GET /diamonds.json
  def index
    @diamonds = Diamond.order("bn_number").all

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
  
  def refresh
    page = Nokogiri::HTML(open("http://www.bluenile.com/diamond-search/grid.html?currency=USD&sortCol=carat&sortDir=asc&shape=RD&minCarat=0.97&maxCarat=10.00&minColor=I&maxColor=D&minPrice=1&maxPrice=6600&minCut=Ideal&maxCut=Signature+Ideal&minClarity=VS1&maxClarity=FL&minFluorescence=Faint&maxFluorescence=None&fluorescence=1&looseDate=false&type=SINGLE&startIndex=0&canvasScrollPosition=0&gridScrollPosition=0&showRowNumbers=false"))   
    
    rows = page.css('div.row')
    
    rows.each do |r|
    
      measurments = r.css('div.viewSelect div')[0]["measurements"]  
      measure_parse = /(?<dia1>[\d\/.]+)x(?<dia2>[\d\/.]+)x(?<depth>[\d\/.]+)/m.match(measurments)
      diams = [measure_parse[:dia1].to_f, measure_parse[:dia2].to_f]
      diameter_min = diams.min
      diameter_max = diams.max
      height_mm = measure_parse[:depth].to_f
      
      price = r.css('div.price').text.gsub(/[$,]/, '').to_f
      
      d = {:bn_number => r["data-sku"],
         # :shape => r.css('div.shape span.a').text,
         :carat_weight => r.css('div.carat').text.to_f,
         :cut_grade => r.css('div.cut span.a').text,
         :color => r.css('div.color').text,
         :clarity => r.css('div.clarity').text,
         :polish => r.css('div.polish').text,
         :symmetry => r.css('div.symmetry').text,
         :total_depth => r.css('div.depth').text.to_f,
         :table_size => r.css('div.table').text.to_f,
         :flourescence => r.css('div.fluor span.a').text,
         :diameter_min => diameter_min.to_f,
         :diameter_max => diameter_max.to_f,
         :height_mm => height_mm.to_f
         };
      
      diamond = Diamond.where({:bn_number => d[:bn_number]}).first
      
      if diamond
        diamond.update_attributes(d)
      else
        diamond = Diamond.create(d)
      end
      
      if !diamond.current_price || diamond.current_price.price != price
        logger.info "Updating price (#{diamond.current_price}) for diamond (#{diamond.bn_number})"
        if diamond.current_price
          logger.info "old price:#{diamond.current_price.price}"
        end
        logger.info "new price: #{price}"
        
        price_snapshot = PriceSnapshot.create({:price => price, :diamond => diamond})
        diamond.current_price = price_snapshot
      end
      
      diamond.save
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
