require 'sinatra'
require 'rubygems'
require 'csv'
require 'pry'
require 'json'
require 'rexml/document'
require 'net/http'
require 'nokogiri'
require 'open-uri'


#METHODS------------------------------------------------------------------------------------------
def get_current_weather(city,state)
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

def weather_icon(icon_id)
  url = "http://openweathermap.org/img/w/#{icon_id}.png"
  return url
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
  @weather_info = get_current_weather(@city, "MA")
  @temperature = convert_F(@weather_info["main"]["temp"]).to_i
  @temp_min = convert_F(@weather_info["main"]["temp_min"]).to_i
  @temp_max = convert_F(@weather_info["main"]["temp_max"]).to_i
  @description = @weather_info["weather"][0]["description"]
  @weather_icon_id = @weather_info["weather"][0]["icon"]
  @weather_icon_url = weather_icon(@weather_icon_id)

  @three_hour_weather = @weather_info

  erb :dashboard
end

get '/test' do
#!/usr/bin/ruby -w

  uri = URI("http://api.openweathermap.org/data/2.5/forecast/daily?q=Cambridge,MA&mode=xml&units=metric&cnt=7")

  @xml_doc = Nokogiri::XML("http://api.openweathermap.org/data/2.5/forecast/daily?q=Cambridge,MA&mode=xml&units=metric&cnt=7")

  erb :test
end

#IF GET A 404 NOT FOUND ERROR--------------------------------------------
not_found do
  @title = "Oops! Jacinda created a bug."
  erb :index
end
