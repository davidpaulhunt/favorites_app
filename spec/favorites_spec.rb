require 'rspec'
require './app.rb'

describe Session do
	
	it 'should have no favorites to start' do
		Session.favorites.should be_empty
	end

	it 'should add a favorite' do
		first_count = Session.favorites.count
		favorite = "Adjustment Bereau"
		Session.add_favorite(favorite)
		second_count = Session.favorites.count

		second_count.should > first_count
	end

end