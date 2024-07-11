class Game
  def initialize(player1_name)
    @player1 = Player.new(player1_name)
    @colour_map = {
      'R' => 'Red',
      'G' => 'Green',
      'B' => 'Blue',
      'Y' => 'Yellow',
      'P' => 'Purple',
      'O' => 'Orange'
    }
    @feedback_map = {
      'B' => 'correct colour and position',
      'W' => 'correct colour but wrong position',
      'N' => 'incorrect colour'
    }
  end

  def start
    fully_matched = false
    turn = 1

    puts "Do you want to play against a (1) Computer or (2) Another Player?"
    choice = gets.chomp.to_i

    if choice == 1
      @player2 = Computer.new
    else
      puts "Enter the second player's name:"
      player2_name = gets.chomp
      @player2 = Player.new(player2_name)
    end

    # Randomly decide who is the codemaker
    if rand(2) == 0
      @codemaker = @player1
      @guesser = @player2
    else
      @codemaker = @player2
      @guesser = @player1
    end

    puts "#{@codemaker.name} is the codemaker."
    puts "#{@guesser.name} is the guesser."

    code = @codemaker.code_choice
    puts "Codemaker's code: #{code.join}" if @codemaker.is_a?(Computer)

    while turn <= 12 && !fully_matched
      puts "Turn #{turn}:"
      guess = @guesser.make_guess
      puts "Guesser's guess: #{guess.join}"
      feedback = give_feedback(code, guess)
      puts "Feedback: #{feedback.join(' ')}"
      fully_matched = feedback.all? { |f| f == 'B' }
      @guesser.update_guess(feedback) if @guesser.is_a?(Computer)
      turn += 1
    end

    if fully_matched
      puts "#{@guesser.name} wins!"
    else
      puts "#{@codemaker.name}'s code was not cracked. The code was: #{code.join}"
    end
  end

  def give_feedback(code, guess)
    feedback = []
    guess.each_with_index do |g, i|
      if g == code[i]
        feedback << 'B'
      elsif code.include?(g)
        feedback << 'W'
      else
        feedback << 'N'
      end
    end
    feedback
  end
end

class Player
  attr_reader :name

  def initialize(name)
    @name = name
    @valid_keys = ['R', 'G', 'B', 'Y', 'P', 'O']
  end

  def code_choice
    code = ""
    loop do
      puts "#{@name}, enter your secret code (e.g., RGBY):"
      code = gets.chomp.upcase.chars
      break if valid_code?(code)

      puts "Invalid code! Please use only the characters R, G, B, Y, P, O."
    end
    code
  end

  def make_guess
    guess = ""
    loop do
      puts "#{@name}, enter your guess (e.g., RGBY):"
      guess = gets.chomp.upcase.chars
      break if valid_code?(guess)

      puts "Invalid guess! Please use only the characters R, G, B, Y, P, O."
    end
    guess
  end

  private

  def valid_code?(code)
    code.length == 4 && code.all? { |char| @valid_keys.include?(char) }
  end
end


class Computer < Player
  def initialize
    super("Computer")
    @colour_map = {
      'R' => 'Red',
      'G' => 'Green',
      'B' => 'Blue',
      'Y' => 'Yellow',
      'P' => 'Purple',
      'O' => 'Orange'
    }
    @current_guess = @colour_map.keys.sample(4)
  end

  def code_choice
    code = @colour_map.keys.sample(4)
    puts "Computer's code choice: #{code.join}"  # Debug output
    code
  end

  def make_guess
    puts "Computer's guess: #{@current_guess}"
    @current_guess
  end

  def update_guess(feedback)
    new_guess = @current_guess.dup

    @current_guess.each_with_index do |color, index|
      if feedback[index] != 'B'
        new_color = @colour_map.keys.sample
        new_guess[index] = new_color while new_color == color
      end
    end

    @current_guess = new_guess
  end
end

# Example of how to start the game
puts "Enter the first player's name:"
player1_name = gets.chomp
game = Game.new(player1_name)
game.start

