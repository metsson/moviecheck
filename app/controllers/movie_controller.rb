require 'open-uri'

class MovieController < ApplicationController

    def index
        @movies = Movie.all
    end

    # movies/:title/:imdbid
    def show
        @movie = Movie.get_rating!(params[:imdbid])
    end

    # /search/:keyword
    def search
        @search_term = params[:keyword]
        @results = JSON.parse open("http://www.omdbapi.com/?s='#{params[:keyword]}").read
    end
end
