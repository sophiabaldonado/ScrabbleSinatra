require 'sinatra'

class Scrabble < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/score' do
    erb :score
  end

  get '/score-many' do
    erb :score_many
  end

  run!
end
