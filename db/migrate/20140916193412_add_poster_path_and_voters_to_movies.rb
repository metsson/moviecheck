class AddPosterPathAndVotersToMovies < ActiveRecord::Migration
    def up
        add_column :movies, :voters, :integer
        add_column :movies, :poster, :string
    end

    def down
        remove_column :movies, :voters
        remove_column :movies, :poster
    end
end
