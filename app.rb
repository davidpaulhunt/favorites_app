require 'sinatra'

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
	@favorites = Session.favorites
	erb :"favorites/index"
end

get '/' do
	redirect "/favorites"
end

post "/favorites" do
	text = params[:title]
	if Session.check_for_dupes(text) == true
		redirect "/error"
	end
	if text.downcase == "ben affleck"
		redirect "/Ben_Affleck"
	elsif text.downcase == "green zone"
		redirect "/Green_Zone"
	elsif Session.add_favorite(text)
		redirect "/favorites"
	else
		redirect "/error"
	end
end


class Session
	@@favorites = []

	def initialize
	end

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
			if existing == title.downcase
				return true
			else
				return false
			end
		end
	end

end