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
    puts "Hi hi hi hi"
    puts "#{@word}"
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty?
    raise ArgumentError unless letter =~ /^[a-z]$/i

    letter = letter.downcase
    return false if @guesses.include? letter 
    return false if @wrong_guesses.include? letter
    if @word.include? letter
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end

  def word_with_guesses
    result = ""
    @word.each_char do |char| 
      result += (@guesses.include? char)? char : '-' 
    end
    result
  end

  def check_win_or_lose
    return :win if !word_with_guesses.include? '-'
    return :lose if @wrong_guesses.length >= 7

    :play 
  end
end
