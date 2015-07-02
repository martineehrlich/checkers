require_relative 'board'

class Game
  attr_reader :board

  def initialize
    @board = Board.new(true)

  end

  def play
    until game_over?
      board.render
      input = player[turn].get_input
      make_move(input)
      change_turn
    end

  end

  def make_move(input)
    
  end

  def game_over?
    board.won?
  end



end
