class GenreController < ApplicationController
    def index
        @genres = Genre.paginate(:page => params[:page]).order('genre ASC')
    end

    def show
        @genre = Genre.find(params[:id])
        if @genre
            @movies = @genre.movies
        end
    end
end
