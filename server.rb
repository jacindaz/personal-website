require 'sinatra'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'
require 'pry'


#CLASSES and METHODS and HELPERS------------------------------------------------------------------
require_relative 'models/npr_class'
require_relative 'helpers/asset_pipeline'
set :base_styles, ["bootstrap.min.css", "jacinda_added_bootstrap.css", "fonts.css", "styles.css"]
set :base_js, ["jquery-ui-1.10.4.min.js"]

#ROUTES AND VIEWS----------------------------------------------------------------------------------

get '/' do
  @title = "Jacinda Zhong"
  erb :index

  # redirect '/about'
end

get '/about' do
  @title = "About"
  erb :about
end

get '/blog' do
  @title = "My Blog"
  erb :blog
end

get '/projects' do
  erb :projects
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













