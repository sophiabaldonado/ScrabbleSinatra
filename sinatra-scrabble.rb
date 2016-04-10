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
    score_word(params["word"])
    word_pairs([params["word"]])
    erb :score
  end

  get '/score/:urlword' do
    score_word(params[:urlword])
    erb :score
  end

  post '/score/:urlword' do
    score_word(params["word"])
    erb :score
  end

  post '/score-many' do
    @user_words = strip_words(params["words"]).split(/ /)
    word_pairs(@user_words)
    erb :score_many
  end

  get '/score-many' do
    erb :score_many
  end

  helpers do
    def strip_words(user_words)
      user_words.gsub(/[\n\r]+/, ' ').gsub(/[^A-Za-z\s]/, '')
    end

  end

  helpers do
    def active_page?(path='')
      request.path_info == ('/' + path)
    end

    def score_word(word)
      @score = Scrabble::Scoring.score(word) unless word.empty?
    end

    def letter_breakdown(word)
      @letters = Scrabble::Scoring.word_letters(word).join(" - ")
      @letter_points = Scrabble::Scoring.word_points(word).join(" - ")
    end

    def word_pairs(words)
      @word_score_pairs = Scrabble::Scoring.word_score_pairs(words)
    end

  end

  run!
end
