require 'spec_helper'

describe "price_snapshots/show" do
  before(:each) do
    @price_snapshot = assign(:price_snapshot, stub_model(PriceSnapshot,
      :diamond => nil,
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/9.99/)
  end
end
