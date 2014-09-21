# For better movie ratings!

filmcheck is a Ruby on Rails app that originates from a mashup in ASP.net MVC 4 coded during my studies at Linnaeus University. What differs in this version is that it uses a single API to retrieve its data from, namely that of [omdapi.org.](http://www.omdapi.org/)

## What's so special about the data?

Given a valid movie title, the app will collect data from several different movie rating sites. Not only will the average scoring give a better hint on how great the movie in question is, it will also collect data about the probability of the score and the total amount of voters. There are also links for further info on IMDb.

## I want to contribute

Glad if you could help! There are tons of things that can be improved. Testing, autocomplete and so on. This repo is completely open to any improvements so feel free to branch out and make a PR!

## Le app in action

Yup, the app is up and running at [filmcheck.se](http://www.filmcheck.se/) but you can, of course, run your own if you want to :)

## App dependencies

You will need to include the following gems in your Gemfile

    # Well... not using posters for the moment
    gem 'paperclip'

    # Pagination gem
    gem 'will_paginate'

    # FB buttons
    gem 'social-buttons'

    # Installed for heroku
    gem 'rails_12factor'

    # If you want to keep your APP_ID secret
    gem 'figaro'
