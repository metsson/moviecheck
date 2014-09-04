class AddActorMovieJointTable < ActiveRecord::Migration
  def change
    create_table :actor_movies, :id => false do |t|
        t.references :actor
        t.references :movie
    end
  end
end
