require 'open-uri'

class Movie < ActiveRecord::Base
    # Many-to-many associations to genre and actors
    # through cast and categorization tables
    has_many :casts
    has_many :categorizations
    has_many :actors, :through => :casts
    has_many :genres, :through => :categorizations

    attr_reader :poster_remote_url
    has_attached_file :poster
    validates_attachment_content_type :poster, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

    # Get cached data for given imdbID or re-generate from API
    def self.get_rating!(imdbID)
      @@movie = find_by_imdb(imdbID) || Movie.new

      # @todo expire cached data!
      if @@movie.new_record? or @@movie.created_at.past?
        api_data = JSON.parse open("http://www.omdbapi.com/?i=#{imdbID}&tomatoes=true&plot=full").read


        if api_data['Response'] == "True"
          @@movie.imdb = api_data['imdbID']
          @@movie.title = api_data['Title']
          @@movie.year = api_data['Year']
          @@movie.poster = poster_remote_url(api_data['Poster'])

          if api_data['tomatoConsensus'] and api_data['tomatoConsensus'] != 'N/A'
            @@movie.plot = api_data['tomatoConsensus']
          elsif api_data['Plot'] != 'N/A'
            @@movie.plot = api_data['Plot']
          else
            raise 'No plot given, in 9 out of 10 cases this means unsufficent API data - abort'
          end

          set_score_and_probability(api_data)
          set_cast_and_genre(api_data)
          set_number_of_voters(api_data)

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
    # Add up total amount of voters from gathered sites
    def self.set_number_of_voters(api_data)
      voters =
      [
        api_data['imdbVotes'].gsub(',','').to_i,
        api_data['tomatoReviews'].gsub(',','').to_i,
        api_data['tomatoUserReviews'].gsub(',','').to_i
      ]

      # Remove falsy voting data
      voters.delete_if{|voter| voter == 0 or voter == "N/A"}

      @@movie.voters = voters.inject(:+)
    end

  private
    # Set the many-to-many relationships between movie and genres/actors
    def self.set_cast_and_genre(api_data)
      api_data["Genre"].split(',').each do |genre|
        begin
          @@movie.genres << Genre.find_or_create_by(genre: genre) unless genre.nil?
        rescue
          # eat
        end
      end

      api_data["Actors"].split(',').each do |actor|
        begin
          @@movie.actors << Actor.find_or_create_by(name: actor) unless actor.nil?
        rescue
          # eat
        end
      end
    end

  private
    # Save image from url locally (paperclip)
    def self.poster_remote_url(url_value)
      @@movie.poster = URI.parse(url_value)
      # Assuming url_value is http://example.com/photos/face.png
      # avatar_file_name == "face.png"
      # avatar_content_type == "image/png"
      @poster_remote_url = url_value
    end
end
