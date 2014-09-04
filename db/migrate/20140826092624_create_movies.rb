class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
        t.string :imdb, null: false
        t.string :year, null: false
        t.float :score, null: false
        t.integer :probability, null: false
        t.string :poster, default: 'default.jpg'
        t.string :title, null: false
        t.text :plot
        t.timestamps
    end
        # Index imdb ID as the movies are often searched by this
        add_index :movies, :imdb
  end
end
