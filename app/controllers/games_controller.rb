require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }.join(" ")
  end

  def valid_word(word, letters)
    word.chars.all? { |char| word.count(char) <= letters.count(char) }
  end

  def compute_score(attempt)
    attempt.size * 1
  end

  def english_word?(word)
    word.downcase!
    response = URI.parse("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    @attempt = params[:guess]
    @attempt.upcase!
    # if valid_word(@attempt, params[:letters].split(" "))
    #   @score = "Good job!"
    # else
    #   @score = "Sorry, you used invalid letters: #{@letters}"
    # end
    if valid_word(@attempt, params[:letters].split(" "))
      if english_word?(@attempt)
        @score = compute_score(@attempt)
        @result = [@score, "well done"]
      else
        @result = [0, "not an english word"]
      end
    else
      @result = [0, "not in the grid"]
    end
  end


end
