require 'spec_helper'

describe "aja_scores/show" do
  before(:each) do
    @aja_score = assign(:aja_score, stub_model(AjaScore,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/Tab Percent/)
    rendered.should match(/Crown Angle/)
    rendered.should match(/Crown Height/)
    rendered.should match(/Pavilion Depth/)
    rendered.should match(/Girdle/)
    rendered.should match(/Depth/)
    rendered.should match(/Polish/)
    rendered.should match(/Symmetry/)
    rendered.should match(/Total Grade/)
  end
end
