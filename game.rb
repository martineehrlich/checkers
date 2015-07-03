require_relative 'board'
require_relative 'players'

class Game
  attr_reader :board, :players
  attr_accessor :turn

  def initialize(player1 = Player.new("m"), player2 = Player.new("n"))
    @board = Board.new(true)
    @players = {:red => player1, :black => player2}
    @turn = :black
  end

  def play
    board.render
    until game_over?
      puts "it's #{players[turn].name}'s turn"
        e = nil
      take_turn
      change_turn
    end
    #player of not turn won the game
  end

  def take_turn
    begin
      board.render
      puts e.message if e
      input = players[turn].get_input
      until validate_input(input)
        input = players[turn].get_input
      end
      make_move(input)
    rescue InvalidMoveError => e
      retry
    end
  end

  def make_move(input)
    piece = board[input.shift]
    piece.perform_moves(input)
  end

  def validate_input(input)
    if board[input[0]].color != turn
     puts "you cannot move that piece, pick again"
     return false
    end
    true
  end

  def change_turn
    @turn = @turn == :black ? :red : :black
  end

  def game_over?
    board.won?
  end

end
