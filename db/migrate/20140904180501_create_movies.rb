class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb
      t.string :title
      t.string :year
      t.text :plot
      t.float :score
      t.integer :probability

      t.timestamps
    end
      add_index :movies, :imdb
  end
end
