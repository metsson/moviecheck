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
            flash[:notice] = 'Well... that wasn\'t good news. The movie you asked for could not be fetched.'
            redirect_to root_path
        end
    end

    # /search/:keyword
    def search
        if params[:keyword].size < 2
            flash[:notice] = 'Sorry buddy, your search keyword was way too short. Try something longer.'
            redirect_to root_path
        end
        @search_term = params[:keyword]
        @search_query = {:s => params[:keyword]}.to_query
        @results = JSON.parse open("http://www.omdbapi.com/?#{@search_query}").read
    end

    # /movies/shitlist (just for fun)
    def shitlist
        @movies = Movie.where('score < 5').order('score DESC').paginate(:page => params[:page], :per_page => 10)
    end
end
