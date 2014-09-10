class Actor < ActiveRecord::Base
    # Association to :cast
    has_many :casts
    has_many :movies, :through => :casts
end
