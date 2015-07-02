require 'colorize'
require 'byebug'
class Piece

  attr_reader :color, :board
  attr_accessor :pos, :king

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @king = false

    board.add_piece(self, pos)
  end

  BLACK_SLIDES = [[1, 1],[1, -1]]
  RED_SLIDES = [[-1, 1],[-1, -1]]

  def king
    @king = true
  end

  def symbol
    self.color == :black ? "[0]".colorize(:black) : "[0]".colorize(:red)
  end

  def king_moves
    RED_SLIDES + BLACK_SLIDES
  end

  def slides
    if self.king
      king_moves
    elsif self.color == :red
      RED_SLIDES
    else
      BLACK_SLIDES
    end
  end

  # def perform_moves!(move_sequence)
  #   if move_sequence.length == 1
  #     if perform_slide(move_sequence[0]) #is a valid move
  #     else
  #       perform_jump(move_sequence[0])
  #     end
  #   else
  #     perform_jump(move_sequence.shift) until move_sequence.empty?
  #   end
  # end
  #
  # def valid_move_seq?
  #
  # end
  #
  # def perform_moves
  #   if valid_move_seq
  #     perform_moves!
  #   else
  #     raises an InvalidMoveError
  #   end
  # end

  def jumps
    (self.slides).map do |move|
      [move[0] * 2, move[1] * 2]
    end
  end

  def moves
    moves = []
      row, col = @pos
    slides.each do |slide|
      test_pos = [row + slide[0], col + slide[1]]
      if board.on_board?(test_pos) && board[test_pos].nil?
        moves << test_pos
      end
    end

    jumps.each_with_index do |jump, idx|
      pos = [row + jump[0], col + jump[1]]
      mid = [(row + slides[idx][0]), (col + slides[idx][1])]
      if board.on_board?(pos) &&
        board[pos].nil? &&
        (!board[mid].nil? && board[mid].color != self.color)
          moves << pos
      end
  end
  moves
end

  def perform_slide(new_pos)
    if moves.include?(new_pos)
      board[self.pos] = nil
      self.pos = new_pos
      board[new_pos] = self
    else
      # raise ArgumentError
      puts "not a valid move"
    end
    maybe_promote
    board.render
  end

  def perform_jump(new_pos)
    if moves.include?(new_pos)
      row, col = self.pos
      new_row, new_col = new_pos
      mid = [(row + new_row) / 2, (col + new_col) / 2 ]
      board[self.pos] = nil
      self.pos = new_pos
      board[new_pos] = self
      board[mid] = nil
    else
      puts "not a valid move"
    end
    maybe_promote
    board.render
  end

  def maybe_promote
    if self.color == :red && self.pos[0] == 0 ||
      self.color == :black && self.pos[0] == 7
        self.king
    end
  end


end
