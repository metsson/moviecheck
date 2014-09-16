require 'open-uri'

class MovieController < ApplicationController

    def index
        @movies = Movie.where('score > 7').order('score DESC').paginate(:page => params[:page], :per_page => 10)
    end

    # movies/:title/:imdbid
    def show
        begin
        @movie ||= Movie.get_rating!(params[:imdbid])

        if @movie
            @suggestions = Movie.where("title LIKE ? OR plot LIKE ?", "%#{@movie.title}%", "%#{@movie.plot}%").take(2)
        end
        rescue
            # Show (generic) error message in view
        end
    end

    # /search/:keyword
    def search
        @search_term = params[:keyword]
        @results = JSON.parse open("http://www.omdbapi.com/?s='#{params[:keyword]}").read
    end
end
