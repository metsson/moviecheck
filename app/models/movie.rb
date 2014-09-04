class Movie < ActiveRecord::Base
    has_many :actors, through: :actor_movies
    has_many :genres, through: :genre_movies    
end
