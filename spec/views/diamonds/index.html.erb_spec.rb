require 'spec_helper'

describe "diamonds/index" do
  before(:each) do
    assign(:diamonds, [
      stub_model(Diamond,
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
      ),
      stub_model(Diamond,
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
      )
    ])
  end

  it "renders a list of diamonds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Bn Number".to_s, :count => 2
    assert_select "tr>td", :text => "Gia Number".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Color".to_s, :count => 2
    assert_select "tr>td", :text => "Clarity".to_s, :count => 2
    assert_select "tr>td", :text => "Cut Grade".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Girdle Min".to_s, :count => 2
    assert_select "tr>td", :text => "Girdle Max".to_s, :count => 2
    assert_select "tr>td", :text => "Cutlet Size".to_s, :count => 2
    assert_select "tr>td", :text => "Polish".to_s, :count => 2
    assert_select "tr>td", :text => "Symmetry".to_s, :count => 2
    assert_select "tr>td", :text => "Flourescence".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Aga Naja Grade".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
