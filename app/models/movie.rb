require 'open-uri'

class Movie < ActiveRecord::Base
    # Many-to-many associations to genre and actors
    # through cast and categorization tables
    has_many :casts
    has_many :categorizations
    has_many :actors, :through => :casts
    has_many :genres, :through => :categorizations

    # Get cached data for given imdbID or re-generate from API
    def self.get_rating!(imdbID)
      @@movie = find_by_imdb(imdbID) || Movie.new

      # @todo expire cached data!
      if @@movie.new_record?
        api_data = JSON.parse open("http://www.omdbapi.com/?i=#{imdbID}&tomatoes=true&plot=full").read

        if api_data['Response'] == "True"
          @@movie.imdb = api_data['imdbID']
          @@movie.title = api_data['Title']
          @@movie.year = api_data['Year']
          @@movie.plot = api_data['Plot']

          set_score_and_probability(api_data)
          set_cast_and_genre(api_data)

          @@movie.save
        else
          raise 'The API responded with falsy JSON ("Response": "False")'
        end
      end

      return @@movie
    end

  private
    # Simply calculate average score for given ratings from the APIs
    def self.set_score_and_probability(api_data)
      ratings =
      [
        api_data['imdbRating'].to_f,
        api_data['tomatoRating'].to_f,
        (api_data['tomatoUserRating'].to_f * 2),
        (api_data['Metascore'].to_f / 10)
      ]

      # Remove falsy rating data
      ratings.delete_if{|rating| rating == 0 or rating == "N/A"}

      @@movie.score = (ratings.inject(:+) / ratings.size).round 2

      # Calculate standard deviation in order to get probability
      standard_deviation = []

      ratings.each do |rating|
        deviation = ((rating - @@movie.score) ** 2).round 2
        standard_deviation.push deviation
      end

      @@movie.probability = ((100 - Math.sqrt(standard_deviation.inject(:+) / ratings.size) * 100).abs).round 0
    end

  private
    # Set the many-to-many relationships between movie and genres/actors
    def self.set_cast_and_genre(api_data)
      api_data["Genre"].split(',').each do |genre|
        genre = Genre.find_or_create_by(genre: genre) unless genre.nil?
        genre.save
        @@movie.genres << genre
      end

      api_data["Actors"].split(',').each do |actor|
        actor = Actor.find_or_create_by(name: actor) unless actor.nil?
        actor.save
        @@movie.actors << actor
      end
    end
end
