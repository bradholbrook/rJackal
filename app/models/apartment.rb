class Apartment < ActiveRecord::Base
	has_many :reviews, dependent: :destroy
	validates :name, uniqueness: { case_sensitive: false },
				       presence: true
	validates :description, length: { maximum: 1000 }
	mount_uploader :image, ApartmentImageUploader
end
