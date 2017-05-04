require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require 'yaml'

before do
  @users = YAML.load_file('users.yaml')
end

helpers do
  def count_users
    @users.keys.count
  end

  def count_interests
    interests = []
    @users.keys.each do |user|
      interests << @users[user][:interests]
    end
    interests.flatten.count
  end
end

not_found do
  redirect "/users"
end

get "/users" do

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
  redirect "/users"
end
