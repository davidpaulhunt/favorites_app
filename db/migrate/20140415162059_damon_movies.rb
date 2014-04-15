class DamonMovies < ActiveRecord::Migration
  def change
  	create_table :favorites do |t|
  		t.string :title
  		t.timestamps
		end
  end
end
