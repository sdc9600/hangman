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
    save_stream = IO.sysopen('save.txt', "w+")
    io = IO.new(save_stream)
    io.puts "#{@secret_word}\n#{@user_secret_word}\n#{@turn}"
  end

  def load_game
    answer = ''
    puts "Would you like to load your previously saved game?"
    until answer == 'y' || answer == 'n'
      answer = gets.chomp.downcase
    end
    if answer == 'y'
    read = IO.sysopen 'save.txt'
    load_stream = IO.new(read)
    @secret_word = load_stream.gets
    @user_secret_word = load_stream.gets
    @turn = load_stream.gets.to_i
    puts @user_secret_word
    else
  end
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
    until @input.match?(/[a-z]/) && @input.length == 1 || @input == 'save'
      @input = gets.chomp.downcase
    end
    if @input == 'save'
      save_game
    end
    @turn += 1
  end
end


game = Hangman.new()
game.start_new_game
game.load_game
until game.turn == 10 || game.secret_word == game.user_secret_word
  game.user_turn
  if game.input == 'save'
    break
  end
  game.update_game_screen
end
