require 'open-uri'
require 'nokogiri'

class BookScraper

	def self.find_book(isbn)

		# Query ISBNsearch and get resulting HTML page with book details
		book_page = Nokogiri::HTML(open("http://isbnsearch.org/isbn/#{isbn}"))
		book_info = Hash.new

		# Parse HTML with Nokogiri and store attributes in hash

		book_info[:title] = book_page.css('div.bookinfo h2').first.content

		book_page.css('div.bookinfo p').each do |attrib|

			attributes = attrib.content.split(': ')

			key = attributes[0].downcase
			key = key.gsub /\s/, '_'		# Replace spaces and dashes with underscores
			key = key.gsub /-/, '_'
			key = key.gsub /list_/, ''		# Remove list_ for price attribute

			book_info[key.to_sym] = attributes[1].gsub /$/, ''
		end

		# Return attribute hash
		book_info
	end
end