Moviecheck::Application.routes.draw do
  root 'movie#index'

  # Custom url to include movie title as well (not for queries though)
  get 'movies/:title/:imdbid', to: 'movie#show', as: 'show_movie'

  # Links for top movies and so on

  # Show all movies for given actor (also index)
  get 'actors/:name/:id', to: 'actor#show', as: 'appears_in'
  get 'actors/all', to: 'actor#index', as: 'all_actors'

  # Show all movies for given genre (also index)
  get 'genres/:genre/:id', to: 'genre#show', as: 'movies_by_genre'
  get 'genres/all', to: 'genre#index', as: 'all_genres'

  # Used for search form but also SEO
  get 'search/:keyword', to: 'movie#search', as: 'search_movie'
end
