require 'sinatra'
require 'rubygems'
require 'csv'
require 'pry'



#METHODS------------------------------------------------------------------------------------------




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

#IF GET A 404 NOT FOUND ERROR--------------------------------------------
not_found do
  @title = "Oops! Jacinda created a bug."
  erb :index
end
