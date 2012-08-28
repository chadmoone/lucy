require "spec_helper"

describe HcaScoresController do
  describe "routing" do

    it "routes to #index" do
      get("/hca_scores").should route_to("hca_scores#index")
    end

    it "routes to #new" do
      get("/hca_scores/new").should route_to("hca_scores#new")
    end

    it "routes to #show" do
      get("/hca_scores/1").should route_to("hca_scores#show", :id => "1")
    end

    it "routes to #edit" do
      get("/hca_scores/1/edit").should route_to("hca_scores#edit", :id => "1")
    end

    it "routes to #create" do
      post("/hca_scores").should route_to("hca_scores#create")
    end

    it "routes to #update" do
      put("/hca_scores/1").should route_to("hca_scores#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/hca_scores/1").should route_to("hca_scores#destroy", :id => "1")
    end

  end
end
