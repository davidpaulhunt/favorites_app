require 'sinatra'

get "/error" do
	"Error"
	erb :"favorites/error"
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
	Session.add_favorite(text)
	redirect "/favorites"
end


class Session
	@@favorites = []

	def initialize
	end

	def self.favorites
		@@favorites
	end

	def self.add_favorite(title)
		@@favorites << title
	end

end