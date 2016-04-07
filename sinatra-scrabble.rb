require 'sinatra'
require_relative 'lib/scrabble'

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

  post '/score-many' do
    @user_words = params["words"].split(/ /)
    @word_score_pairs = Scrabble::Scoring.word_score_pairs(@user_words)
    erb :score_many
  end

  get '/score-many' do
    erb :score_many
  end

  run!
end
