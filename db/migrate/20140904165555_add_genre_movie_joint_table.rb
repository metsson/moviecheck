class AddGenreMovieJointTable < ActiveRecord::Migration
  def change
    create_table :genre_movies, :id => false do |t|
        t.references :genre
        t.references :movie
    end
  end
end
