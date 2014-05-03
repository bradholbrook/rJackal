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

	#link button to submit form
	def link_to_submit(*args, &block)
		link_to_function (block_given? ? capture(&block) : args[0]), "$(this).closest('form').submit()", args.extract_options!
	end
	
	def link_to_function(name, *args, &block)
     html_options = args.extract_options!.symbolize_keys

     function = block_given? ? update_page(&block) : args[0] || ''
     onclick = "#{"#{html_options[:onclick]}; " if html_options[:onclick]}#{function}; return false;"
     href = html_options[:href] || '#'

     content_tag(:a, name, html_options.merge(:href => href, :onclick => onclick))
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
