require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :database, 'postgres://goblin:123@localhost/friends'

class Video < ActiveRecord::Base
end

get '/' do
	"Hello World!"
end

get '/videos/new' do
	haml :'videos/new'
end

get '/videos/:id' do
	@video = Video.find(params[:id])
	haml :'videos/show'
	# 1. find video with id
end


post "/videos/create" do

  video = Video.new(params[:video])

  if video.save
    redirect to("/videos/#{video.id}")
  else
   	redirect to('/videos/new')
  end

end