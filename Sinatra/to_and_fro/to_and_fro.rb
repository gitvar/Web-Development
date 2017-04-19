require "yaml"

require 'sinatra/reloader'
require 'tilt/erubis'
# require 'sinatra' # This also works - for now.
# require 'tilt' # This also works, but probably loads all of the other language libraries as well.

get "/" do
  redirect "/main"
end

get "/main" do
  @title = "Main"

  erb :main
end

get "/second" do
  @title = "Second"

  erb :second
end
