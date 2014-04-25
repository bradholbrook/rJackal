require 'spec_helper'

describe "static_pages/index" do
  before(:each) do
    assign(:static_pages, [
      stub_model(StaticPage,
        :index => "Index",
        :about => "About",
        :contact => "Contact"
      ),
      stub_model(StaticPage,
        :index => "Index",
        :about => "About",
        :contact => "Contact"
      )
    ])
  end

  it "renders a list of static_pages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Index".to_s, :count => 2
    assert_select "tr>td", :text => "About".to_s, :count => 2
    assert_select "tr>td", :text => "Contact".to_s, :count => 2
  end
end
