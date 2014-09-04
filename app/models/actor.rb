class Actor < ActiveRecord::Base
    # Association to :cast
    has_many :movies
    has_many :movies, :through => :casts
end
