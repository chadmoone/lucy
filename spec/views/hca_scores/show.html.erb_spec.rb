require 'spec_helper'

describe "hca_scores/show" do
  before(:each) do
    @hca_score = assign(:hca_score, stub_model(HcaScore,
      :diamond => "",
      :score => "9.99",
      :light_return => "Light Return",
      :fire => "Fire",
      :scintillation => "Scintillation",
      :spread => "Spread"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/9.99/)
    rendered.should match(/Light Return/)
    rendered.should match(/Fire/)
    rendered.should match(/Scintillation/)
    rendered.should match(/Spread/)
  end
end
