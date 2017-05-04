require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @users = YAML.load_file('users.yaml')
end

helpers do
end

not_found do
  puts "Not Found"
  redirect "/users"
end

get "/users" do
  puts "/users"

  erb :users
end

get "/:user_name" do
  @user_name = params[:user_name].to_sym
  @name = @user_name.to_s.capitalize
  @email = @users[@user_name][:email]
  @interests = @users[@user_name][:interests]

  erb :user
end

get "/" do
  puts "/"
  redirect "/users"
end
