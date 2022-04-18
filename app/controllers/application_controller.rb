class ApplicationController < Sinatra::Base

  get '/' do
    { message: "Hello world" }.to_json
  end

  # Add this line to set the Content-Type header for all responses
  set :default_content_type, 'application/json'

  get '/games' do
    # get all the games from the database
    games = Game.all
    # return a JSON response with an array of all the game data
    games.to_json
  end

  # use the :id syntax to create a dynamic route
  get '/games/:id' do
      # look up the game in the database using its ID
      game = Game.find(params[:id])
      # send a JSON-formatted response of the game data
      # include associated reviews 
      # include associated user for each review
      game.to_json(include: { reviews: { include: :user } })
  end

end
