class Cast < ActiveRecord::Base
    # Joined table model
    belongs_to :actor
    belongs_to :movie
end
