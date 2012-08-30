require 'spec_helper'

describe "aja_scores/index" do
  before(:each) do
    assign(:aja_scores, [
      stub_model(AjaScore,
        :diamond => nil,
        :tab_percent => "Tab Percent",
        :crown_angle => "Crown Angle",
        :crown_height => "Crown Height",
        :pavilion_depth => "Pavilion Depth",
        :girdle => "Girdle",
        :depth => "Depth",
        :polish => "Polish",
        :symmetry => "Symmetry",
        :total_grade => "Total Grade"
      ),
      stub_model(AjaScore,
        :diamond => nil,
        :tab_percent => "Tab Percent",
        :crown_angle => "Crown Angle",
        :crown_height => "Crown Height",
        :pavilion_depth => "Pavilion Depth",
        :girdle => "Girdle",
        :depth => "Depth",
        :polish => "Polish",
        :symmetry => "Symmetry",
        :total_grade => "Total Grade"
      )
    ])
  end

  it "renders a list of aja_scores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Tab Percent".to_s, :count => 2
    assert_select "tr>td", :text => "Crown Angle".to_s, :count => 2
    assert_select "tr>td", :text => "Crown Height".to_s, :count => 2
    assert_select "tr>td", :text => "Pavilion Depth".to_s, :count => 2
    assert_select "tr>td", :text => "Girdle".to_s, :count => 2
    assert_select "tr>td", :text => "Depth".to_s, :count => 2
    assert_select "tr>td", :text => "Polish".to_s, :count => 2
    assert_select "tr>td", :text => "Symmetry".to_s, :count => 2
    assert_select "tr>td", :text => "Total Grade".to_s, :count => 2
  end
end
