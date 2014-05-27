require 'sinatra'
require 'rubygems'
require 'csv'
require 'pry'
require 'slim'


#METHODS------------------------------------------------------------------------------------------




#ROUTES AND VIEWS----------------------------------------------------------------------------------

get '/' do
  @title = "Jacinda Zhong"
  slim :home
end

get '/about' do
  @title = "About Jacinda"
  slim :about
end

get '/contact' do
  @title = "Contact Me"
  slim :contact
end

get '/funsies' do
  @title = "Just for Funsies"
  slim :funsies
end

get '/coding' do
  @title = "Why Code"
  slim :coding
end

#IF GET A 404 NOT FOUND ERROR--------------------------------------------
not_found do
  @title = "Oops! Jacinda created a bug."
  slim :home
end
