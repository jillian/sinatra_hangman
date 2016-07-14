class HangpersonGame
  attr_accessor :word, :guesses, :wrong_guesses

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError if letter.nil?
    raise ArgumentError if letter == "%"
    raise ArgumentError if letter == ""
    # raise ArgumentError if !letter.match(/^[[:alpha:]]$/)

    letter = letter.downcase
    return false if @guesses.include? letter 
    return false if @wrong_guesses.include? letter
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
  end

  def word_with_guesses
    placeholder = ""
    @word.each_char do |char| 
      placeholder += (@guesses.include? char)? char : '-' 
    end
    placeholder
  end

  def check_win_or_lose
    if @word.downcase.chars.sort.join == self.guesses.chars.sort.join
      :win 
    elsif self.wrong_guesses.length >= 7
      :lose 
    else 
      :play 
    end
  end
end
