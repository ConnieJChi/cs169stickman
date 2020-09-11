class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
    
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
    
    
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @guess_list = []
    @wrong_guess_list = []
  end
    
  def guess(word)
    if word == "" or word == nil
       raise ArgumentError, 'Argument is an empty string'
    elsif word =~ /[^a-zA-Z]/
        raise ArgumentError, 'Argument is not a letter'
    end
      
    word = word.downcase
      
    if @guess_list.include? word or @wrong_guess_list.include? word
        return false
    end
      
    if @word.include? word
        @guesses = word 
        @guess_list.append(word)
        return true
    else
        @wrong_guesses = word
        @wrong_guess_list.append(word)
        return true
    end
  end
    
  def word_with_guesses
      ret_str = ""
      @word.split("").each do |c|
          if @guess_list.include? c
              ret_str = ret_str + c
          else
              ret_str = ret_str + "-"
          end
      end
      
      return ret_str
  end
    
  def check_win_or_lose
      if word_with_guesses == @word
          return :win
      elsif @wrong_guess_list.length >= 7
          return :lose
      else
          return :play
      end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
    
    

end
