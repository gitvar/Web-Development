# list.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  # Find all files in the public directory:
  @files = Dir.glob("public/*").select { |file| File.ftype(file) == "file" }

  # Remove prepended directory names:
  @files.map! { |file| File.basename(file) }.sort

  @sort = params[:sort]
  @files.reverse! if params[:sort] == "desc"

  erb :list
end
