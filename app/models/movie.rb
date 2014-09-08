require 'open-uri'

class Movie < ActiveRecord::Base
    # Many-to-many associations to genre and actors
    # through cast and categorization tables
    has_many :casts
    has_many :categorizations
    has_many :actors, :through => :casts
    has_many :genres, :through => :categorizations

    # Simple search method
    def self.search(search)
      if search
        find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
      else
        find(:all)
      end
    end

    # Get cached data for given imdbID or re-generate from API
    def self.get_rating!(imdbID)
      movie = find_by_imdb(imdbID)

      # @todo expire cached data!
      if movie
        return movie
      else
        movie = JSON.parse open("http://www.omdbapi.com/?i=#{imdbID}&tomatoes=true&plot=full").read

        if movie['Response'] == "True"
          movie = Movie.create(
            imdb: movie['imdbID'],
            title: movie['Title'],
            year: movie['Year'],
            plot: movie['Plot'],
            score: average_score(movie),
            probability: 32
            )
          
          movie.save
          set_cast_and_genre(movie)
        else
          raise 'The API responded with falsy JSON ("Response": "False")'
        end
      end

      return movie
    end

  private
    def self.average_score(json_data)
      json_data['imdbRating'] + json_data['tomatoRating'] + (json_data['tomatoUserRating'] * 2) + json_data['Metascore']
    end

  private 
    def self.set_cast_and_genre(json_data)
      json_data["Genre"].split(',').each do |genre| 
        genre = Genre.create(genre: genre) unless genre.nil?
        self.genres << genre
      end      

      json_data["Actors"].split(',').each do |actor| 
        actor = Actor.create(name: actor) unless actor.nil?
        self.actors << actor
      end
    end      
end
