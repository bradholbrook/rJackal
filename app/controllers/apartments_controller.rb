require 'mechanize'
require 'htmlentities'

class ApartmentsController < ApplicationController
	def new
		@term = params[:q]
		@apartments = search_web_by_name(@term)
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
	end

	private
    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
	    params.require(:apartment).permit(:id, :name, :city, :state, :zip, :phone, :max_bedrooms, :min_bedrooms, :min_price, :max_price, :image_tag, :image, :remote_image_url)
    end

    def search_web_by_name(name)
	  	agent = Mechanize.new
		coder = HTMLEntities.new

	  	page = agent.get('http://www.forrent.com/results.php?search_type=communityname&ssradius=30&page_type_id=name&main_field=' << coder.encode(name) << '&x=13&y=6&resultsPerPage=40')
	  	#page.search('a.searchMatchTitle')
	  	results = page.search('section.exactmatch')

	  	apartments = Array.new
		i = 0
		#make new apartment objects
		results.each do |result|
			apartment = Apartment.new
			apartment.name = result.at_css('header h2 a').text
			#apartment.name = result.at_css('div.unit a').text.strip!
			apartment.city = result.at_css('span.locality').text
			apartment.state = result.at_css('abbr.region').text
			apartment.zip = result.at_css('span.postal-code').text

			#1-3 Bedroom | $890-$1455 #Studio-2 Bedroom | $444-$795 #3 Bedroom | $875
			rooms_and_price_match = /(?<min_bedrooms>\d+|studio)[-]?(?<max_bedrooms>(\d+)?)\s+bedroom\s+\|\s+\$?(?<min_price>(\d+|call\s+for\s+price))[-]?\$?(?<max_price>(\d+)?)/i.match(result.at_css('div.unit a').text.strip!)
			apartment.min_bedrooms = rooms_and_price_match[:min_bedrooms]
			if rooms_and_price_match[:max_bedrooms]
				apartment.max_bedrooms = rooms_and_price_match[:max_bedrooms]
			else
				apartment.max_bedrooms = rooms_and_price_match[:min_bedrooms]
			end
			apartment.min_price = rooms_and_price_match[:min_price]
			if rooms_and_price_match[:max_price]
				apartment.max_price = rooms_and_price_match[:max_price]
			else
				apartment.max_price = rooms_and_price_match[:min_price]
			end
			apartment.phone = result.at_css('a[name=propPhoneNumber]').text
			apartment.image_tag = result.at_css('img')[:src]
			apartments[i] = apartment
			i = i + 1
		end

		return apartments
    end
end