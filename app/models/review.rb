class Review < ActiveRecord::Base
	belongs_to :apartment
	validates :body, presence: true
end