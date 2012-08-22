require 'spec_helper'

describe "diamonds/show" do
  before(:each) do
    @diamond = assign(:diamond, stub_model(Diamond,
      :bn_number => "Bn Number",
      :gia_number => "Gia Number",
      :carat_weight => "9.99",
      :color => "Color",
      :clarity => "Clarity",
      :cut_grade => "Cut Grade",
      :height_mm => "9.99",
      :diameter_max => "9.99",
      :diameter_min => "9.99",
      :table_size => "9.99",
      :total_depth => "9.99",
      :crown_angle => "9.99",
      :crown_height => "9.99",
      :pavillion_angle => "9.99",
      :pavillion_depth => "9.99",
      :star_length => "9.99",
      :lower_half_length => "9.99",
      :girdle_min => "Girdle Min",
      :girdle_max => "Girdle Max",
      :cutlet_size => "Cutlet Size",
      :polish => "Polish",
      :symmetry => "Symmetry",
      :flourescence => "Flourescence",
      :hca_score => "9.99",
      :aga_naja_grade => "Aga Naja Grade",
      :ship_time => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Bn Number/)
    rendered.should match(/Gia Number/)
    rendered.should match(/9.99/)
    rendered.should match(/Color/)
    rendered.should match(/Clarity/)
    rendered.should match(/Cut Grade/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/Girdle Min/)
    rendered.should match(/Girdle Max/)
    rendered.should match(/Cutlet Size/)
    rendered.should match(/Polish/)
    rendered.should match(/Symmetry/)
    rendered.should match(/Flourescence/)
    rendered.should match(/9.99/)
    rendered.should match(/Aga Naja Grade/)
    rendered.should match(/1/)
  end
end
