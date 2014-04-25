module ApplicationHelper
	
	#global reusable page title	
	def full_title(page_title)
		base = "Review Jackal"
		if page_title.empty?
			base
		else
			"#{base} | #{page_title}"
		end
	end

	#magic to access devises gglobal user resource
	def resource_name
		:user
	end

	def resource
		@resource ||= User.new
	end

	def devise_mapping
		@devise_mapping ||+ Devise.mappings[:user]
	end


	def bootstrap_version
		"3.1.1"
	end
end
