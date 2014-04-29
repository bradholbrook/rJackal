class ApartmentsController < ApplicationController
	def show
		input = params[:id]
		begin
			if input =~ /\A\d+\Z/
				@apartment = Apartment.find(input)
			elsif input
				@apartment = Apartment.find_by_name(input)
			else
				#query rest of apartment information
			end
		rescue ActiveRecord::RecordNotFound => exception
			redirect_to not_found_path
		end
	end
	def create
		name = params[:name]
		@apartment = Apartment.create(:name => name)
		render :show, :locals => { :id => @apartment.id }
	end
end