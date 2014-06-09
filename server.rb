require 'sinatra'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'forecast_io'

#CLASSES and METHODS----------------------------------------------------------------------------
require_relative 'models/weather_class'
require_relative 'models/npr_class'



def xml_(xml_file_path, xml_doc)
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
  @title = "Jacinda's Projects"
  @current_weather_object = OpenMapsWeather.new

  if params[:query] == nil
    @city = "Cambridge"
    @state = "MA"
  else
    split = params[:query].split(',' || " ")
    cleaned_array = split.collect{ |query_item| query_item.strip }
    @city = cleaned_array[0]
    @state = cleaned_array[1]
  end

  #Current Weather Variables-----------------------------------------------------------------------
  @weather_info = @current_weather_object.get_current_weather(@city, @state)
  @current_weather_hash = @current_weather_object.current_weather_hash(@weather_info)

  #Weather Forecast Variables-----------------------------------------------------------------------
  @date = today_date
  @weather_forecast_object = OpenMapsWeather.new
  @xml_doc = @weather_forecast_object.forecast_xml(@city, @state)

  @temp_array = []
  @xml_doc.xpath('/weatherdata/forecast/time/temperature').each do |element|
    @temp_hash2 = {}
    element.each do |key,value|
      @temp_hash2[key.to_sym] = @weather_forecast_object.celcius_to_faren_num(value.to_f)
    end
    @temp_array << @temp_hash2
  end


  #Pulling in Image icon id's for weather pictures-----------------------------------------------------
  @forecast_icon_object = OpenMapsWeather.new
  @icon_array = @forecast_icon_object.xml_array_nested_hash('/weatherdata/forecast/time/symbol', @xml_doc)
  @icon_url_array = @forecast_icon_object.icon_url_array(@icon_array)

  #binding.pry

  erb :dashboard
end



get '/test' do
  @title = "Test Page"

  #NPR Stories API variables and calls---------------------------------------------------
  @npr_object = NPR.new("NPR")
  @npr_data = @npr_object.npr_api_xml("npr_key", "http://api.npr.org/query?id=1056,3&orgId=1&output=XML&sort=featured")
  @npr_logo = @npr_object.logo_src

  @npr_title = @npr_data.xpath('//nprml/list/title').text

  @npr_data_array = []

  @npr_data.xpath('//nprml/list/story').each do |story_info|
    @npr_nested_hash = {}

    url = story_info.xpath('link[@type="html"]').text
    @npr_nested_hash[:url] = url

    title = story_info.xpath('title').text
    @npr_nested_hash[:title] = title

    teaser = story_info.xpath('teaser').text
    @npr_nested_hash[:teaser] = teaser

    @npr_data_array << @npr_nested_hash
  end

  erb :test
end

#IF GET A 404 NOT FOUND ERROR----------------------------------------------------------
not_found do
  @title = "Oops! Jacinda created a bug."
  erb :index
end













