#!/usr/bin/env ruby
require "net/http"
require "json"

def fetch_articles_from_api(keyword)
    url = "http://0.0.0.0:3000/articles"
    uri = URI(url)

    url_params = { "query" => keyword}
    uri.query = URI.encode_www_form(url_params)

    answer = Net::HTTP.get(uri)
    answer = JSON.parse(answer)
end
def output_data(result)
	json_data = fetch_articles_from_api result
	json_data["data"].each do |key, array|
		key["attributes"].each do |key1, array1|
			puts "-----#{key1}-----"
			puts array1
			puts 
		end
	end
	nil
end
def get_func(result)
	if result[0].eql? "searchdata"
		puts output_data result[1]
	else
		puts "command not found"
	end
	
end
while true do
	a = gets.chomp
	result = a.split(" ").map { |s| s.to_s }
	if result[0].eql? "exit"
		break
	else
		get_func result
	end
end
#puts fetch_articles_from_api a[0]