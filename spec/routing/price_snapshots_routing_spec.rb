require "spec_helper"

describe PriceSnapshotsController do
  describe "routing" do

    it "routes to #index" do
      get("/price_snapshots").should route_to("price_snapshots#index")
    end

    it "routes to #new" do
      get("/price_snapshots/new").should route_to("price_snapshots#new")
    end

    it "routes to #show" do
      get("/price_snapshots/1").should route_to("price_snapshots#show", :id => "1")
    end

    it "routes to #edit" do
      get("/price_snapshots/1/edit").should route_to("price_snapshots#edit", :id => "1")
    end

    it "routes to #create" do
      post("/price_snapshots").should route_to("price_snapshots#create")
    end

    it "routes to #update" do
      put("/price_snapshots/1").should route_to("price_snapshots#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/price_snapshots/1").should route_to("price_snapshots#destroy", :id => "1")
    end

  end
end
