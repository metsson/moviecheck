class Genre < ActiveRecord::Base
    # Association to :categorization
    has_many :categorizations
    has_many :movies, :through => :categorizations
end
