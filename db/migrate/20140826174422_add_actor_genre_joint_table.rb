class AddActorGenreJointTable < ActiveRecord::Migration
  def change
    create_table :actor_genres do |t|
        t.integer :actor_id
        t.integer :genre_id
    end
  end
end
