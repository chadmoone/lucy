require 'spec_helper'

describe "hca_scores/index" do
  before(:each) do
    assign(:hca_scores, [
      stub_model(HcaScore,
        :diamond => "",
        :score => "9.99",
        :light_return => "Light Return",
        :fire => "Fire",
        :scintillation => "Scintillation",
        :spread => "Spread"
      ),
      stub_model(HcaScore,
        :diamond => "",
        :score => "9.99",
        :light_return => "Light Return",
        :fire => "Fire",
        :scintillation => "Scintillation",
        :spread => "Spread"
      )
    ])
  end

  it "renders a list of hca_scores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Light Return".to_s, :count => 2
    assert_select "tr>td", :text => "Fire".to_s, :count => 2
    assert_select "tr>td", :text => "Scintillation".to_s, :count => 2
    assert_select "tr>td", :text => "Spread".to_s, :count => 2
  end
end
