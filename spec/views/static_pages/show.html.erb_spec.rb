require 'spec_helper'

describe "static_pages/show" do
  before(:each) do
    @static_page = assign(:static_page, stub_model(StaticPage,
      :index => "Index",
      :about => "About",
      :contact => "Contact"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Index/)
    rendered.should match(/About/)
    rendered.should match(/Contact/)
  end
end
