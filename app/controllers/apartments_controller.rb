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
		@apartment = Apartment.new(apartment_params)
		
		begin
			if @apartment.save
				get_details(@apartment)
				#get_reviews(@apartment)
			else
				@apartment = Apartment.find_by_name(apartment_params[:name])
			end
		rescue ActiveRecord::RecordNotFound => exception
			redirect_to not_found_path #TODO: give this local params for an error message
		end
		redirect_to apartment_path(@apartment)
	end

	private

    def apartment_params
	    params.require(:apartment).permit(:id, :name, :city, :state, :zip, :phone, :max_bedrooms, :min_bedrooms, :min_price, :max_price, :image_tag, :detail_page, :description, :image, :remote_image_url)
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
			apartment.name = result.at_css('a.searchMatchTitle').text
			apartment.city = result.at_css('span.locality').text
			apartment.state = result.at_css('abbr.region').text
			apartment.zip = result.at_css('span.postal-code').text

			#1-3 Bedroom | $890-$1455 #Studio-2 Bedroom | $444-$795 #3 Bedroom | $875
			#apartment.name = result.at_css('div.unit a').text.strip!
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
			apartment.detail_page = result.at_css('a.searchMatchTitle')[:href]
			apartments[i] = apartment
			i = i + 1
		end

		return apartments
    end

    def get_details(apartment)
    	agent = Mechanize.new
		coder = HTMLEntities.new

	  	page = agent.get(coder.encode(apartment.detail_page))

	  	apartment.description = page.search('aside#proShortDesc p').text
	  	apartment.address = page.search('span.street-address')[0].text
    end

    def get_reviews(apartment)
    	agent = Mechanize.new
		coder = HTMLEntities.new

	  	page = agent.get('http://www.apartmentratings.com/rate/SearchResults?query=' << apartment.name << '&page=0&sort=DEFAULT')

	  	#find the right apartment result
	  	#loop do
	  		results = page.search('div.result')
		  	results.each do |review|
		  		if review.at_css('div.address').text.include? apartment.address
		  			page = link_with(:text => review.at_css('span.complexName a').text).click
		  			#break
		  		end
		  	end
		  	#link = page.link_with(:text => 'next')
		  	#if link
		  	#	page.link_with(:text => 'next').click
		  	#else 
		  	#	page = nil
		  	#end
	  	#end
	  	if page
	  		#on result page
	  		apartment.reviews.create('did it omg')
	  	else
	  	end
    end
end