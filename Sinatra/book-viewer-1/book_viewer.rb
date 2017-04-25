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
  chap_number = params[:number].to_i
  no_of_chapters = @contents.size
  redirect "/" unless (1..no_of_chapters).to_a.include?(chap_number)

  @chapter_title = @contents[chap_number - 1]
  @chapter = File.read("data/chp#{chap_number}.txt")

  erb :chapter
end
