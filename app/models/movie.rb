class Movie < ActiveRecord::Base
    has_many :genres, :through :genre_movies
    has_many :actors, :through :genre_movies
end
