require "spec_helper"

describe DiamondsController do
  describe "routing" do

    it "routes to #index" do
      get("/diamonds").should route_to("diamonds#index")
    end

    it "routes to #new" do
      get("/diamonds/new").should route_to("diamonds#new")
    end

    it "routes to #show" do
      get("/diamonds/1").should route_to("diamonds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/diamonds/1/edit").should route_to("diamonds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/diamonds").should route_to("diamonds#create")
    end

    it "routes to #update" do
      put("/diamonds/1").should route_to("diamonds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/diamonds/1").should route_to("diamonds#destroy", :id => "1")
    end

  end
end
