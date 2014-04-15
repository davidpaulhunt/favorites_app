require 'sinatra'
require 'sinatra/activerecord'

set :database, "sqlite:///favorites_app.db"


get "/error" do
	erb :"favorites/error"
end

get "/Green_Zone" do
	erb :"favorites/green_zone"
end

get "/Ben_Affleck" do
	erb :"favorites/benaffleck"
end

get "/favorites" do
	@favorites = Favorite.all
	erb :"favorites/index"
end

get "/favorites/:id" do
	@favorite = Favorite.find(params[:id])
	erb :"favorites/show"
end


get '/' do
	redirect "/favorites"
end

get '/favorites/:id/edit' do
	@favorite = Favorite.find(params[:id])
	erb :"favorites/edit"
end

get '/favorites/:id' do
	@favorite = Favorite.find(params[:id])
	erb :"favorites/show"
end

# post "/favorites" do
# 	text = params[:title]
# 	if Favorite.check_for_dupes(text) == true
# 		redirect "/error"
# 	elsif Favorite.is_empty(text) == true
# 		redirect "/error"
# 	end
# 	if text.downcase == "ben affleck"
# 		redirect "/Ben_Affleck"
# 	elsif text.downcase == "green zone"
# 		redirect "/Green_Zone"
# 	elsif Favorite.add_favorite(text)
# 		redirect "/favorites"
# 	else
# 		redirect "/error"
# 	end
# end

post "/favorites" do
	new_favorite = Favorite.new
	new_favorite.title = params[:title]
	if new_favorite.save
		redirect "/favorites"
	else
		redirect "/error"
	end
end

put "/favorites/:id" do
	@favorite = Favorite.find(params[:id])
	if @favorite.update_attributes(params[:favorite])
		redirect "/favorites/#{@favorite.id}"
	else
		redirect "/error"
	end
end

delete "/favorites/:id" do
	favorite = Favorite.find(params[:id])
	if favorite.delete
		redirect "/favorites"
	else
		redirect "/favorites/:id"
	end
end


class Favorite < ActiveRecord::Base
	@@favorites = []

	def self.favorites
		@@favorites
	end

	def self.add_favorite(title)
		if title.downcase == "green zone"
			return false
		else
			@@favorites << title
		end
	end

	def self.check_for_dupes(title)
		@@favorites.each do |existing|
			if existing.downcase == title.downcase
				return true
			end
		end
		return false
	end

	def self.is_empty(title)
		if title == "" || title == " "
			return true
		end
	end

end