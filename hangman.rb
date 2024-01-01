require 'pry-byebug'

class Hangman
  attr_reader :turn, :user_secret_word, :secret_word, :input
  def initialize
    @word_array = []
    @secret_word = ''
    @user_secret_word = ''
    @turn = 0
    @input = ''
  end

  def save_game
    #save_stream = IO.sysopen('save.txt', "w")
    #io = IO.new(save_stream)
    writer = File.open('save.txt', 'w+')
    writer.puts "#{@secret_word}"
    writer.puts "#{@user_secret_word}"
    writer.puts "#{@turn}"
    writer.close
  end

  def load_game
    reader = File.open('save.txt')
    answer = ''
    puts "Would you like to load your previously saved game?"
    until answer == 'y' || answer == 'n'
      answer = gets.chomp.downcase
    end
    if answer == 'y'
    @secret_word = reader.gets
    @user_secret_word = reader.gets
    @turn = reader.gets.to_i
    reader.close
    else
  end
end

def start_new_game
    words_stream = File.open('words.txt')
    until words_stream.eof? == true
      @word_array.push(words_stream.gets.chomp)
    end
    until @secret_word.length >= 5 && @secret_word.length <= 12
      @secret_word = @word_array.sample
    end
    puts @secret_word
    @user_secret_word = @secret_word.gsub(/\w/, "_")
    puts @user_secret_word
  end

  def update_game_screen
    @secret_word.chars.each_index do
      |i|
      if @secret_word[i] == @input
        @user_secret_word[i] = @secret_word[i]
      end
    end
    puts @user_secret_word
    @input = ''
  end

  def user_turn
    puts "Please guess the secret word for hangman! Turns left: #{10 - @turn}"
     until @input.match?(/[a-z]/) && @input.length == 1 || @input == 'save'
     @input = gets.chomp.downcase
     end
     save_game if @input == 'save'

    @turn += 1
  end
end

game = Hangman.new

game.start_new_game
game.load_game
until game.turn == 10 || game.secret_word == game.user_secret_word
  game.user_turn
  break if game.input == 'save'

  game.update_game_screen
end
