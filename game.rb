require_relative 'board'

class Game
  attr_reader :board, :players
  attr_accessor :turn

  def initialize(player1, player2)
    @board = Board.new(true)
    @players = {:red => player1, :white => player2}
    @turn = :white
  end

  def play
    until game_over?
      board.render
      puts "it's #{players[turn]}'s turn"
      input = players[turn].get_input
      make_move(input)
      system("clear")
      board.render
      change_turn
    end
    #player of not turn won the game
  end

  def make_move(input)
    piece = board[input.shift]
    piece.perform_moves(input)
  end

  def change_turn
    @turn = @turn == :white ? :red : :white
  end

  def game_over?
    board.won?
  end



end
