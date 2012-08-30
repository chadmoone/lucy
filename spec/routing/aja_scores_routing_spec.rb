require "spec_helper"

describe AjaScoresController do
  describe "routing" do

    it "routes to #index" do
      get("/aja_scores").should route_to("aja_scores#index")
    end

    it "routes to #new" do
      get("/aja_scores/new").should route_to("aja_scores#new")
    end

    it "routes to #show" do
      get("/aja_scores/1").should route_to("aja_scores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/aja_scores/1/edit").should route_to("aja_scores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/aja_scores").should route_to("aja_scores#create")
    end

    it "routes to #update" do
      put("/aja_scores/1").should route_to("aja_scores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/aja_scores/1").should route_to("aja_scores#destroy", :id => "1")
    end

  end
end
