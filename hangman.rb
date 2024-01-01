class Hangman
  attr_reader :turn, :user_secret_word, :secret_word
  def initialize
    @word_array = []
    @secret_word = ''
    @user_secret_word = ''
    @turn = 0
    @input = ''
  end

def start_new_game
    IO.sysopen 'words.txt'
    words_stream = IO.new(5)
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
    until @input.match?(/[a-z]/) && @input.length == 1
      @input = gets.chomp.downcase
    end
    @turn += 1
  end
end

game = Hangman.new()
game.start_new_game
until game.turn == 10 || game.secret_word == game.user_secret_word
  game.user_turn
  game.update_game_screen
end
