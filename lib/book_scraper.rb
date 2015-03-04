require 'open-uri'
require 'nokogiri'

class BookScraper

	def self.find_book(isbn)

		book_page = Nokogiri::HTML(open("http://isbnsearch.org/isbn/#{isbn}"))
		book_info = Hash.new

		book_info[:title] = book_page.css('div.bookinfo h2').first.content

		book_page.css('div.bookinfo p').each do |attrib|

			attributes = attrib.content.split(': ')

			key = attributes[0].downcase
			key = key.gsub /\s/, '_'
			key = key.gsub /-/, '_'

			book_info[key.to_sym] = attributes[1].gsub /$/, ''
		end

		book_info
	end
end