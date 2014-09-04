class Movie < ActiveRecord::Base
    # Many-to-many associations to genre and actors
    # through cast and categorization tables
    has_many :casts
    has_many :categorizations
    has_many :actors, :through => :casts
    has_many :genres, :through => :categorizations
end
