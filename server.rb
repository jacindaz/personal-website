require 'sinatra'
require 'rubygems'
require 'csv'
require 'pry'
require 'json'
require 'net/http'



#METHODS------------------------------------------------------------------------------------------
def get_weather(city,state)
  uri = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city},#{state}")
  response = Net::HTTP.get(uri)
  weather_data = JSON.parse(response)
  return weather_data
end

def convert_F(kelvin_temp)
  celcius = kelvin_temp - 273.15
  farenheit = (celcius * 1.8) + 32
  return farenheit
end


#ROUTES AND VIEWS----------------------------------------------------------------------------------
get('/bootstrap.css'){ css :bootstrap }

get '/' do
  @title = "Jacinda Zhong"
  erb :index
end

get '/about' do
  @title = "About Jacinda"
  erb :about
end

get '/contact' do
  @title = "Contact Me"
  erb :contact
end

get '/funsies' do
  @title = "Just for Funsies"
  erb :funsies
end

get '/coding' do
  @title = "Why Code"
  erb :coding
end

get '/blog' do
  @title = "My Blog"
  erb :blog
end

get '/dashboard' do
  @title = "Jacinda's Dashboard"
  @city = "Cambridge"
  @weather_info = get_weather(@city, "MA")
  @temperature = convert_F(@weather_info["main"]["temp"]).to_i
  @temp_min = convert_F(@weather_info["main"]["temp_min"]).to_i
  @temp_max = convert_F(@weather_info["main"]["temp_max"]).to_i
  @description = @weather_info["weather"][0]["description"]

  erb :dashboard
end

#IF GET A 404 NOT FOUND ERROR--------------------------------------------
not_found do
  @title = "Oops! Jacinda created a bug."
  erb :index
end
