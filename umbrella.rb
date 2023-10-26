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

lat = loc.fetch("lat").to_s
lon = loc.fetch("lng").to_s


pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_API_KEY")

weather_url = "https://api.pirateweather.net/forecast/" +  ENV.fetch("PIRATE_WEATHER_API_KEY")+ "/" + lat +"," + lon


weather_response = HTTP.get(weather_url)
parsed_wresponse = JSON.parse(weather_response)


current_stats = parsed_wresponse.fetch("currently")

temperature_current = current_stats.fetch("temperature")
temperature_current_c = (temperature_current - 32.0)*(5.0 /9.0)


pp "The temperature in " + user_location.gsub("%20", " ") + " is currently " + temperature_current_c.round(2).to_s + " deg C"
