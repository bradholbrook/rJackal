class Apartment < ActiveRecord::Base
	validates :name, :uniqueness => { :case_sensitve => false },
				     :presence => true
	mount_uploader :image, ApartmentImageUploader
end
