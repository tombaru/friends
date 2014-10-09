require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require './uploaders/file_uploader'
require 'pry'

use Rack::Logger

helpers do
  def logger
    request.logger
  end
end

set :database, 'postgres://goblin:123@localhost/friends'

class Video < ActiveRecord::Base
  mount_uploader :file, FileUploader
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