require 'sinatra'
require_relative 'lib/scrabble'
# require_relative '/lib/score'

class SinatraScrabble < Sinatra::Base

  get '/' do
    erb :index
  end

  get '/score' do
    erb :score
  end

  post '/score' do
    @score = Scrabble::Scoring.score(params["word"])
    erb :score
  end

  get '/score-many' do
    erb :score_many
  end

  run!
end
