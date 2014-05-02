require 'mechanize'
require 'htmlentities'

class ApartmentsController < ApplicationController
	def new
		#call search helper function
		@term = params[:q]
		@results = search_web_by_name(@term)
		@apartments = Array.new
		i = 0
		#make new apartment objects
		@results.each do |result|
			apartment = Apartment.new
			apartment.name = result.text
			@apartments[i] = apartment
			i = i + 1
		end
	end
	def show
		begin
			@apartment = Apartment.find(params[:id])
		rescue ActiveRecord::RecordNotFound => exception
			redirect_to not_found_path
		end
	end
	def create
		@apartment = Apartment.create(apartment_params)
		@apartment = Apartment.find_by_name(apartment_params[:name]) if @apartment.id.nil?
		redirect_to apartment_path(@apartment)
		#@apartment = Apartment.new(apartment_params)
		#respond_to do |format|
	    #  if @apartment.save
		#	redirect_to apartment_path(@apartment.id)
	    #  else
	    #    format.html { render :new }
	    #  end
	    #end
	end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
	    params.require(:apartment).permit(:name)
    end

    def search_web_by_name(name)
	  	agent = Mechanize.new
		coder = HTMLEntities.new

	  	page = agent.get('http://www.forrent.com/results.php?search_type=communityname&ssradius=30&page_type_id=name&main_field=' << coder.encode(name) << '&x=13&y=6&resultsPerPage=40')
	  	return page.search('a.searchMatchTitle')
    end
end