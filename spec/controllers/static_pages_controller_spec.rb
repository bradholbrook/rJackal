require 'spec_helper'
describe "Static Pages" do
  describe "visit index" do
    it "visits the index page" do
      visit root_path
      expect(page).to have_content('Home Page')
    end
  end
  describe "visiting about" do
    it "visits the about page" do
      visit about_path
      expect(page).to have_content('About Page')
    end
  end
  describe "visiting contact" do
    it "visits the contact page" do
      visit contact_path
      expect(page).to have_content('Contact Page')
    end
  end
end
