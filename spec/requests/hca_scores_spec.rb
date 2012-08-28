require 'spec_helper'

describe "HcaScores" do
  describe "GET /hca_scores" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get hca_scores_path
      response.status.should be(200)
    end
  end
end
