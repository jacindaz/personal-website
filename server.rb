require 'sinatra'
require 'rubygems'
require 'csv'
require 'pry'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require_relative 'weather.rb'


#METHODS------------------------------------------------------------------------------------------

def usa_today_api(key_variable_name)
  key = ENV[key_variable_name]
  uri = URI("http://api.usatoday.com/open/articles/topnews?api_key=#{key}")
  response = Net::HTTP.get(uri)
  news_data = JSON.parse(response)
  return news_data
end

def xml_loop(xml_file_path, xml_doc)
  hash = {}
  xml_doc.xpath(xml_file_path).each do |attributes|
    #puts "outer loop: attributes #{attributes}"
    attributes.each do |key, value|
      #puts "each loop: key/value is #{key}, #{value}"
      hash[key.to_sym] = value
    end
  end
  hash
end


def xml_loop2(xml_file_path, xml_doc)
  hash = {}
  xml_doc.xpath(xml_file_path).each do |element|
    element.xpath.each do |attribute|
      puts attribute
    end
  end
  hash
end


def today_date
  return Date.today
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
  @current_weather_object = Weather.new

  @weather_info = @current_weather_object.get_current_weather(@city, "MA")
  @temperature = @current_weather_object.convert_F(@weather_info["main"]["temp"]).to_i
  @temp_min = @current_weather_object.convert_F(@weather_info["main"]["temp_min"]).to_i
  @temp_max = @current_weather_object.convert_F(@weather_info["main"]["temp_max"]).to_i
  @description = @weather_info["weather"][0]["description"]
  @weather_icon_id = @weather_info["weather"][0]["icon"]
  @weather_icon_url = @current_weather_object.weather_icon(@weather_icon_id)

  erb :dashboard
end

get '/test' do
  @date = today_date
#!/usr/bin/ruby -w
  uri = URI("http://api.openweathermap.org/data/2.5/forecast/daily?q=Cambridge,MA&mode=xml&units=metric&cnt=7")
  response = Net::HTTP.get(uri)
  @xml_doc = Nokogiri::XML(response)
  #binding.pry

  @data = @xml_doc.xpath('/weatherdata/forecast/time[@day="2014-05-30"]')
  @temp_hash = xml_loop('/weatherdata/forecast/time[@day="2014-05-30"]/temperature', @xml_doc)
  @temp_faren = celcius_to_faren(@temp_hash)

  @temp_array = []
  @xml_doc.xpath('/weatherdata/forecast/time/temperature').each do |element|
    puts "outer loop: element is #{element}"
    @temp_hash2 = {}
    element.each do |key,value|
      puts "each loop: key/value is #{key}, #{value}"
      @temp_hash2[key.to_sym] = celcius_to_faren_num(value.to_f)

    end
    @temp_array << @temp_hash2
  end

  #binding.pry

  erb :test
end

#IF GET A 404 NOT FOUND ERROR--------------------------------------------
not_found do
  @title = "Oops! Jacinda created a bug."
  erb :index
end













