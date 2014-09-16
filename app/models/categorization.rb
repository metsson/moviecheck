class Categorization < ActiveRecord::Base
    # Joined table model
    belongs_to :genre
    belongs_to :movie

    validates_uniqueness_of :genre_id, :scope => :movie_id
end
