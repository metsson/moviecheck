class AddPosterPathAndVotersToMovies < ActiveRecord::Migration
    def up
        add_column :movies, :voters, :integer
    end

    def down
        remove_column :movies, :voters
    end
end
