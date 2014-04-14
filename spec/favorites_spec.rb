require 'rspec'
require './app.rb'

describe Favorites do
	
	it 'should have no favorites to start' do
		Favorites.favorites.should be_empty
	end

	it 'should add a favorite' do
		first_count = Favorites.favorites.count
		favorite = "Adjustment Bereau"
		Favorites.add_favorite(favorite)
		second_count = Favorites.favorites.count

		second_count.should > first_count
	end

end