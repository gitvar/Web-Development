require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/chapters/1" do
  @title = "Chapter 1"
  @contents = File.readlines("data/toc.txt") # readlines
  @chapter = File.read("data/chp1.txt") # read

  erb :chapter
end

get "/" do
  @title = "Sherlock Holmes"
  @contents = File.readlines('data/toc.txt')

  erb :home
end
