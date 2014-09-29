require 'sinatra'
require 'haml'
#require 'sinatra/reloader'

get '/hi' do
  "Hello World!"
end

get '/video' do
	haml :video
end

get '/search' do
	haml :search
end

post "/search" do
	name = params[:name]
  count = params[:count]
  # redirect to('/answer')
  haml :answer, locals: {name: name, count: count}
end

get '/answer' do
	haml :answer
end

