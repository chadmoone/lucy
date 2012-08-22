require 'spec_helper'

describe "diamonds/edit" do
  before(:each) do
    @diamond = assign(:diamond, stub_model(Diamond,
      :bn_number => "MyString",
      :gia_number => "MyString",
      :carat_weight => "9.99",
      :color => "MyString",
      :clarity => "MyString",
      :cut_grade => "MyString",
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
      :girdle_min => "MyString",
      :girdle_max => "MyString",
      :cutlet_size => "MyString",
      :polish => "MyString",
      :symmetry => "MyString",
      :flourescence => "MyString",
      :hca_score => "9.99",
      :aga_naja_grade => "MyString",
      :ship_time => 1
    ))
  end

  it "renders the edit diamond form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => diamonds_path(@diamond), :method => "post" do
      assert_select "input#diamond_bn_number", :name => "diamond[bn_number]"
      assert_select "input#diamond_gia_number", :name => "diamond[gia_number]"
      assert_select "input#diamond_carat_weight", :name => "diamond[carat_weight]"
      assert_select "input#diamond_color", :name => "diamond[color]"
      assert_select "input#diamond_clarity", :name => "diamond[clarity]"
      assert_select "input#diamond_cut_grade", :name => "diamond[cut_grade]"
      assert_select "input#diamond_height_mm", :name => "diamond[height_mm]"
      assert_select "input#diamond_diameter_max", :name => "diamond[diameter_max]"
      assert_select "input#diamond_diameter_min", :name => "diamond[diameter_min]"
      assert_select "input#diamond_table_size", :name => "diamond[table_size]"
      assert_select "input#diamond_total_depth", :name => "diamond[total_depth]"
      assert_select "input#diamond_crown_angle", :name => "diamond[crown_angle]"
      assert_select "input#diamond_crown_height", :name => "diamond[crown_height]"
      assert_select "input#diamond_pavillion_angle", :name => "diamond[pavillion_angle]"
      assert_select "input#diamond_pavillion_depth", :name => "diamond[pavillion_depth]"
      assert_select "input#diamond_star_length", :name => "diamond[star_length]"
      assert_select "input#diamond_lower_half_length", :name => "diamond[lower_half_length]"
      assert_select "input#diamond_girdle_min", :name => "diamond[girdle_min]"
      assert_select "input#diamond_girdle_max", :name => "diamond[girdle_max]"
      assert_select "input#diamond_cutlet_size", :name => "diamond[cutlet_size]"
      assert_select "input#diamond_polish", :name => "diamond[polish]"
      assert_select "input#diamond_symmetry", :name => "diamond[symmetry]"
      assert_select "input#diamond_flourescence", :name => "diamond[flourescence]"
      assert_select "input#diamond_hca_score", :name => "diamond[hca_score]"
      assert_select "input#diamond_aga_naja_grade", :name => "diamond[aga_naja_grade]"
      assert_select "input#diamond_ship_time", :name => "diamond[ship_time]"
    end
  end
end
