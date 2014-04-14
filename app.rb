require 'sinatra'

get "/favorites" do
	@favorites = Favorites.new
	erb :"favorites/index"
end

get '/' do
	"Hello World"
end


class Favorites
	@@favorites = []
	
	def initialize
	end

	def self.favorites
		@@favorites
	end

	def self.add_favorite(favorite)
		@@favorites << favorite
	end

end