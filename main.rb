class Game
  def initialize(player1_name, player2_name = nil)
    @player1 = Player.new(player1_name)
    @player2 = player2_name ? Player.new(player2_name):
    Computer.new
  end

  colour_map = {
    'R':'Red',
    'G':'Green',
    'B':'Blue',
    'Y':'Yellow',
    'P':'Purple',
    'O':'Orange'
  }

  feedback_map = {
    'B':'correct colour and position'
    'W':'correct colour but wrong position'
    'N':'incorrect colour'
  }

  def start
    fully_matched = false
    
  end

end
class Player
  def initialize()
    
  end

  def code_choice
    code = gets.chomp
  end
  
  def feedback
    guess = gets.chomp
  end

end
class Computer < Player
  def initialize()
    
  end

  def code_choice
    code = colour_map.keys.sample(4)

end
