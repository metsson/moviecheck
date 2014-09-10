Moviecheck::Application.routes.draw do
  root 'movie#index'

  # Custom url to include movie title as well (not for queries though)
  get 'movies/:title/:imdbid', to: 'movie#show', as: 'show_movie'

  # Show all movies for given actor
  get 'actors/:name/:id', to: 'actor#show', as: 'appears_in'

  # Show all movies for given genre
  get 'genres/:genre/:id', to: 'genre#show', as: 'movies_by_genre'

  # Used for search form but also SEO
  get 'search/:keyword', to: 'movie#search', as: 'search_movie'
end
