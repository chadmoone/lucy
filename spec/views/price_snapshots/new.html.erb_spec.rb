require 'spec_helper'

describe "price_snapshots/new" do
  before(:each) do
    assign(:price_snapshot, stub_model(PriceSnapshot,
      :diamond => nil,
      :price => "9.99"
    ).as_new_record)
  end

  it "renders new price_snapshot form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => price_snapshots_path, :method => "post" do
      assert_select "input#price_snapshot_diamond", :name => "price_snapshot[diamond]"
      assert_select "input#price_snapshot_price", :name => "price_snapshot[price]"
    end
  end
end
