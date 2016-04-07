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
    @user_words = params["words"].gsub(/[\n\r]+/, ' ')
    @user_words = strip_words(@user_words).split(/ /)
    @word_score_pairs = Scrabble::Scoring.word_score_pairs(@user_words)
    erb :score_many
  end

  get '/score-many' do
    erb :score_many
  end

  helpers do
    def strip_words(words_array)
      words_array.gsub(/[^A-Za-z\s]/, '')
    end

  end

  run!
end
