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
    # text.split("\n\n").map do |paragraph|
    #   "<p>#{paragraph}</p>"
    # end.join
    text.split("\n\n").each_with_index.map do |paragraph, index|
      "<p id=paragraph#{index}>#{paragraph}</p>"
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

# Calls the block for each chapter, passing that chapter's number, name, and
# contents.
def each_chapter
  @contents.each_with_index do |name, index|
    number = index + 1
    chapter = File.read("data/chp#{number}.txt")
    yield number, name, chapter
  end
end

# This method returns an Array of Hashes representing chapters that match the
# specified query. Each Hash contain values for its :name and :number keys.
# results[0][:name] would provide the name of the first chapter matching the
# search criteria.
def chapters_matching(query)
  results = []

  return results if query.nil? || query == ''

  each_chapter do |number, name, chapter|
    matches = {}
    chapter.split("\n\n").each_with_index do |paragraph, index|
      matches[index] = paragraph if paragraph.include?(query)
    end
    results << { number: number, name: name, paragraphs: matches } if matches.any?
  end

  results
end

get "/search" do
  @results = chapters_matching(params[:query])

  erb :search
end
