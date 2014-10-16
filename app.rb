require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'json'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require './uploaders/file_uploader'
# require 'pry'

use Rack::Logger

helpers do
  def logger
    request.logger
  end
end

set :database, 'postgres://goblin:123@localhost/friends'

class Video < ActiveRecord::Base
  mount_uploader :file, FileUploader

  validates :title, :episode, :season, :file, presence: true
  validates :episode, uniqueness: { scope: :season }

  before_save :check_audio_streams
 
  private

  def capitalize
    self.title = title.capitalize
  end
  
  def check_audio_streams
    string = `ffmpeg -i #{self.file.path}`
    if string.scan(/Audio/).count != 2
      errors.add(:file, "audio streams != 2")
      false 
    end
  end
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
  @video = Video.new(params[:video])
  if @video.save
    redirect to("/videos/#{@video.id}")
  else
   	haml :'videos/new', locals: { video: @video }
  end

end