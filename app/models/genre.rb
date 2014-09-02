class Genre < ActiveRecord::Base
    has_many :movies, through: :genre_movies
end
