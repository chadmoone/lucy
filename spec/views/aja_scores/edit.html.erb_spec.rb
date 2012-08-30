require 'spec_helper'

describe "aja_scores/edit" do
  before(:each) do
    @aja_score = assign(:aja_score, stub_model(AjaScore,
      :diamond => nil,
      :tab_percent => "MyString",
      :crown_angle => "MyString",
      :crown_height => "MyString",
      :pavilion_depth => "MyString",
      :girdle => "MyString",
      :depth => "MyString",
      :polish => "MyString",
      :symmetry => "MyString",
      :total_grade => "MyString"
    ))
  end

  it "renders the edit aja_score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => aja_scores_path(@aja_score), :method => "post" do
      assert_select "input#aja_score_diamond", :name => "aja_score[diamond]"
      assert_select "input#aja_score_tab_percent", :name => "aja_score[tab_percent]"
      assert_select "input#aja_score_crown_angle", :name => "aja_score[crown_angle]"
      assert_select "input#aja_score_crown_height", :name => "aja_score[crown_height]"
      assert_select "input#aja_score_pavilion_depth", :name => "aja_score[pavilion_depth]"
      assert_select "input#aja_score_girdle", :name => "aja_score[girdle]"
      assert_select "input#aja_score_depth", :name => "aja_score[depth]"
      assert_select "input#aja_score_polish", :name => "aja_score[polish]"
      assert_select "input#aja_score_symmetry", :name => "aja_score[symmetry]"
      assert_select "input#aja_score_total_grade", :name => "aja_score[total_grade]"
    end
  end
end
