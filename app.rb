require 'sinatra'
require 'sinatra/activerecord'
require 'json'

set :database, 'postgres://goblin:123@localhost/friends'

class Video < ActiveRecord::Base

end

get '/' do
  "Hello World!"
end
