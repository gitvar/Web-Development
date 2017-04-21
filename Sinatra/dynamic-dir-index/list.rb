# list.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  # Find ONLY the filenames in the 'public' directory.
  # No prepended directory names like 'public/demo1.html'.
  # And no directory names (if there are directories in 'public').
  @files = Dir.glob("public/*").map do |file|
    File.basename(file) if File.ftype(file) == "file"
  end.compact.sort

  @sort = params[:sort]
  @files.reverse! if params[:sort] == "desc"

  erb :list
end
