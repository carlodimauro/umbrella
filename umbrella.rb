require "http"
require "json"

pp "Where are you located?"

user_location = gets.chomp.gsub(" ","%20")
# user_location = "Chicago"
map_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

response = HTTP.get(map_url)
parsed_response = JSON.parse(response)

results = parsed_response.fetch("results")
first_result = results.at(0)
geo = first_result.fetch("geometry")
loc = geo.fetch("location")

lat = loc.fetch("lat")
lon = loc.fetch("lng")


pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")
