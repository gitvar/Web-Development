require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

before do
  @title = "The Adventures of Sherlock Holmes"
  @author = "Sir Arthur Conan Doyle"
  @contents = File.readlines("data/toc.txt")
end

helpers do
  def insert_paragraphs(text)
    text.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end
end

not_found do
  redirect "/"
end

get "/" do
  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  redirect "/" if number < 1 || number > @contents.size
  @chapter_title = @contents[number - 1]
  @chapter = File.read("data/chp#{number}.txt")

  erb :chapter
end
