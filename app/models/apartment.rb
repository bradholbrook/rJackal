class Apartment < ActiveRecord::Base
	validates :name, :uniqueness => { :case_sensitve => false },
				     :presence => true
end
