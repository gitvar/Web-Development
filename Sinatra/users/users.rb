# users.rb
require "yaml"

require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

before do
  @users = YAML.load_file("users.yaml")
end

# @users = {:jamy=>{:email=>"jamy.rustenburg@gmail.com", :interests=>["woodworking", "cooking", "reading"]}, :nora=>{:email=>"nora.alnes@yahoo.com", :interests=>["cycling", "basketball", "economics"]}, :hiroko=>{:email=>"hiroko.ohara@hotmail.com", :interests=>["politics", "history", "birding", "cycling"]}, :danny=>{:email=>"danny.bd@hotmail.com", :interests=>["movies", "tennis", "golf", "athletics", "cycling"]}}

helpers do
  def count_interests(users)
    users.each_value.map { |user| user[:interests] }.flatten.count
    # users.reduce(0) do |sum, (_name, user)|
    #   sum + user[:interests].size
    # end
  end
end

get "/" do
  redirect "/users"
end

get "/users" do
  erb :users
end

get "/:user_name" do
  @user_name = params[:user_name].to_sym
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests]

  erb :user
end
