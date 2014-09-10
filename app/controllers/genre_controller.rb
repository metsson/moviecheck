class GenreController < ApplicationController
    def index
        @genres = Genre.paginate(:page => params[:page])
    end

    def show
        @genre = Genre.find(params[:id])
    end
end
