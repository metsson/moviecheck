class AddActorMovieJointTable < ActiveRecord::Migration
  def change
    create_table :actor_movies do |t|
        t.belongs_to :actor
        t.belongs_to :movie
    end
  end
end
