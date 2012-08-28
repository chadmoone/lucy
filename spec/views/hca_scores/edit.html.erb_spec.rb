require 'spec_helper'

describe "hca_scores/edit" do
  before(:each) do
    @hca_score = assign(:hca_score, stub_model(HcaScore,
      :diamond => "",
      :score => "9.99",
      :light_return => "MyString",
      :fire => "MyString",
      :scintillation => "MyString",
      :spread => "MyString"
    ))
  end

  it "renders the edit hca_score form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => hca_scores_path(@hca_score), :method => "post" do
      assert_select "input#hca_score_diamond", :name => "hca_score[diamond]"
      assert_select "input#hca_score_score", :name => "hca_score[score]"
      assert_select "input#hca_score_light_return", :name => "hca_score[light_return]"
      assert_select "input#hca_score_fire", :name => "hca_score[fire]"
      assert_select "input#hca_score_scintillation", :name => "hca_score[scintillation]"
      assert_select "input#hca_score_spread", :name => "hca_score[spread]"
    end
  end
end
