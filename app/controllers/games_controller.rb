require 'open-uri'
class GamesController < ApplicationController
  def new
    @random_letters = ('a'..'z').to_a
    grid = []
    10.times do
      grid << @random_letters.sample
    end
    @letters = grid.map(&:capitalize)
  end

  def score
    @word = params[:playerinput].upcase
    data = open("https://wagon-dictionary.herokuapp.com/#{@word}").read
    words = JSON.parse(data)

    @letters = params[:letters]
    if words['found']
      letters = @word.split('')
      @result = if letters.all? { |x| params[:letters].include?(x) == true }
                  "Congratulations! #{@word} is a valid English word!"
                else
                  "Sorry, but #{@word} can't be built out of #{@letters}"
                end
    else
      @result = "Sorry, but #{@word} does not seem to be a valid English word..."
    end
  end
end
