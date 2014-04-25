require 'spec_helper'

describe "static_pages/new" do
  before(:each) do
    assign(:static_page, stub_model(StaticPage,
      :index => "MyString",
      :about => "MyString",
      :contact => "MyString"
    ).as_new_record)
  end

  it "renders new static_page form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", static_pages_path, "post" do
      assert_select "input#static_page_index[name=?]", "static_page[index]"
      assert_select "input#static_page_about[name=?]", "static_page[about]"
      assert_select "input#static_page_contact[name=?]", "static_page[contact]"
    end
  end
end
