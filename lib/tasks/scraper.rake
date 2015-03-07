# encoding: utf-8

namespace :scraper do
  desc "scrape data from UT OTC"
  task scrape: :environment do
	# encoding: utf-8
	
	require 'open-uri'
	
	require 'Nokogiri'


	# store url to be scraped
	url = "http://www.otc.utexas.edu/ATlistAll.jsp"

	# Parse the page with Nokogiri
	page = Nokogiri::HTML(open(url))

	# Initialize empty arrays
	title = []
	link = []
	details = []
	technology = []
	uriSubarray = []

	# Store data in arrays. the .text only records the text from that css. It needs to be taken off to get the href.
	page.css('h4 a').each do |line|
		#strip the title from the URL because if I try to take the text like for 'details' then I get an 'encoding utf-8' error and I couldn't figure out the problem or find an answer
	  uriSubarray = line['href'].strip.split(/title=/)

	    if uriSubarray.length == 2
	      title << uriSubarray[1]
	    else
	      title << 'error'
	    end
	end

	page.css('h4 a').each do |line|
	  link << line['href']
	end

	page.css('p.indented').each do |line|
	  details << line.text.strip
	end


	title.length.times do |i|

		# create new Post
		@post = Post.new
		@post.title = title[i]
		@post.link = link[i]
		@post.details = details[i]
		@post.institution = 'UT'

		# save Post
		@post.save
	end

	# display the results in terminal
	#puts technology[0]
  end

  desc "TODO"
  task destroy_all_posts: :environment do
  	Post.destroy_all
  end

end
