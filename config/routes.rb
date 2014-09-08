Moviecheck::Application.routes.draw do
  root 'movie#index'

  # Custom url to include movie title as well (not for queries though)
  get 'movies/:title/:imdbid', to: 'movie#show', as: 'show_movie'

  # Used for search form but also SEO
  get 'search/:keyword', to: 'movie#search', as: 'search_movie'
end
