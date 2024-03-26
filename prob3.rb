require 'httparty'
require 'json'

def fetch_time_data(area, location)
  response = HTTParty.get("http://worldtimeapi.org/api/timezone/#{area}/#{location}")
  JSON.parse(response.body)
end

def display_current_time(time_data, area, location)
  current_time = time_data['datetime']
  puts "The current time in #{area}/#{location} is #{current_time}"
end

area = ARGV[0]
location = ARGV[1]
time_data = fetch_time_data(area, location)
display_current_time(time_data, area, location)
