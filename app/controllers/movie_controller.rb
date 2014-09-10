require 'open-uri'

class MovieController < ApplicationController

    def index
        @movies = Movie.paginate(:page => params[:page])
    end

    # movies/:title/:imdbid
    def show
        begin
        @movie = Movie.get_rating!(params[:imdbid])

        if @movie
            @suggestions = Movie.where("title LIKE ? OR plot LIKE ?", "%#{@movie.title}%", "%#{@movie.plot}%")
            @suggestions.pop(@movie.id)
        end
        rescue
            # Show error message
        end
    end

    # /search/:keyword
    def search
        @search_term = params[:keyword]
        @results = JSON.parse open("http://www.omdbapi.com/?s='#{params[:keyword]}").read
    end
end
