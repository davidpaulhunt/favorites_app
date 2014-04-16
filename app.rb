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

get '/favorites/:id/delete' do
	@favorite = Favorite.find(params[:id])
	erb :"favorites/delete"
end

get '/favorites/:id' do
	@favorite = Favorite.find(params[:id])
	erb :"favorites/show"
end

post "/favorites" do
	new_favorite = Favorite.new
	new_favorite.title = params[:title]
	favorites = Favorite.all 
	favorites.each do |favorite|
		if new_favorite.title.downcase == favorite.title.downcase
			redirect "/error"
		end
	end
	Favorite::ALL_MOVIES.each do |movie|
		@damon = false;
		if new_favorite.title.downcase == movie.downcase
			@damon = true;
			break
		end
	end
	if @damon == false
		redirect "/error"
	end
	if new_favorite.title.downcase == "ben affleck"
		redirect "/Ben_Affleck"
	elsif new_favorite.title.downcase == "green zone"
		redirect "/Green_Zone"
	end
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
	ALL_MOVIES = [
		"We Bought a Zoo",
		"Happy Feet Two",
		"Margaret",
		"Contagion",
		"The Adjustment Bureau",
		"True Grit",
		"Hereafter",
		"Green Zone",
		"Invictus",
		"The Informant!",
		"Ponyo",
		"Che: Part Two",
		"The Bourne Ultimatum",
		"Ocean's Thirteen",
		"The Good Shepherd",
		"The Departed",
		"Syriana",
		"The Brothers Grimm",
		"Ocean's Twelve",
		"The Bourne Supremacy",
		"Jersey Girl",
		"EuroTrip",
		"Stuck on You",
		"The Bourne Identity",
		"Confessions of a Dangerous Mind",
		"Spirit: Stallion of the Cimarron",
		"Gerry",
		"The Majestic",
		"Ocean's Eleven",
		"All the Pretty Horses",
		"Finding Forrester",
		"The Legend of Bagger Vance",
		"Titan A.E.",
		"The Talented Mr. Ripley",
		"Dogma",
		"Rounders",
		"Saving Private Ryan",
		"Good Will Hunting",
		"The Rainmaker ",
		"Chasing Amy",
		"Courage Under Fire",
		"Glory Daze",
		"Geronimo: An American Legend",
		"School Ties",
		"Mystic Pizza"
	]

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