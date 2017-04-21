require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  @author = "Sir Arthur Conan Doyle"
  @contents = File.readlines('data/toc.txt')

  erb :home
end

get "/chapters/1" do
  @title = "The Adventures of Sherlock Holmes"
  @author = "Sir Arthur Conan Doyle"
  @chapter = File.read('data/chp1.txt')

  erb :chapter
end
