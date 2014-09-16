class GenreController < ApplicationController
    def index
        @genres = Genre.paginate(:page => params[:page], :per_page => 1).order('genre ASC')
    end

    def show
        @genre = Genre.find(params[:id])
        if @genre
            @movies = @genre.movies
        end
    end
end
