require 'htmlentities'

class SearchController < ApplicationController
  def search
  	agent = Mechanize.new
	coder = HTMLEntities.new
	string = params[:q]
  	page = agent.get('http://www.forrent.com/results.php?search_type=communityname&ssradius=30&page_type_id=name&main_field=' << coder.encode(string) << '&x=13&y=6&resultsPerPage=40')
  	@links = page.search('a.searchMatchTitle')
  end
end
