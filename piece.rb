require 'colorize'
require 'byebug'
class Piece

  attr_reader :color, :board, :king
  attr_accessor :pos

  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @king = false

    board.add_piece(self, pos)
  end

  BLACK_SLIDES = [[1, 1],[1, -1]]
  RED_SLIDES = [[-1, 1],[-1, -1]]

  def king?
    self.king = true
  end

  def symbol
    self.color == :black ? " 0 ".colorize(:black) : " 0 ".colorize(:red)
  end

  def king_moves
    RED_SLIDES + BLACK_SLIDES
  end

  def slides
    if self.king?
      king_moves
    elsif self.color == :red
      RED_SLIDES
    else
      BLACK_SLIDES
    end
  end

  def jumps
    (self.slides).map do |move|
      [move[0] * 2, move[1] * 2]
    end
  end

  def moves
    moves = []
    self.pos = row, col
    slides.each_with_index do |x, y|
      pos = [row + x, col + y]
      if pos.on_board? && pos.empty?
        moves << pos
      end
    end

    jumps.each_with_index do |x, y|
      pos = [row + x, col + y]
      mid = [(row + x) / 2, (col + y) / 2 ]
      if pos.on_board? && pos.empty? && (!board[mid].empty? && board[mid].color != self.color)
        moves << pos
      end
  end

  def perform_slide(new_pos)
    if moves.include?(new_pos)
      board[self.pos] = nil
      self.pos = new_pos
    else
      puts "not a valid move"
    end
  end

  def perform_jump(new_pos)
    if moves.include?(new_pos)
      self.pos = row, col
      new_pos = new_row, new_col
      mid [(row + new_row) / 2, (col + new_col) / 2 ]
      board[self.pos] = nil
      self.pos = new_pos
      board[mid] = nil
    else
      puts "not a valid move"
    end
  end

  def maybe_promote
    if self.color == :red && self.pos[0] == 0 || self.color == :red && self.pos[0] == 6
      self.king?
    end
  end


end
