class Categorization < ActiveRecord::Base
    # Joined table model
    belongs_to :genre
    belongs_to :movie
end
