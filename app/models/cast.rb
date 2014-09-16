class Cast < ActiveRecord::Base
    # Joined table model
    belongs_to :actor
    belongs_to :movie

     validates_uniqueness_of :actor_id, :scope => :movie_id
end
