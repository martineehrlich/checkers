require_relative 'piece'
require 'byebug'


class Board

  attr_reader :rows

  def initialize(fill_board = true)
    make_starting_grid(fill_board)
    render
  end

  def [](pos)
    i, j = pos
    @rows[i][j]
  end

  def []=(pos, piece)
    i, j = pos
    @rows[i][j] = piece
  end

  def add_piece(piece, pos)
    self[pos] = piece
  end
  def won?
    pieces.all? { |piece| piece.color == :red } || pieces.all? { |piece| piece.color == :black }
  end

  def place_pieces(color)
    @rows.each_with_index do |_, row_idx|
      row = color == :black ? [0, 1, 2] : [5, 6, 7]
      row.each do |idx|
        next if (row_idx + idx).even?
        Piece.new(color, [idx, row_idx], self)
      end
    end
  end

  def make_starting_grid(fill_board)
    @rows = Array.new(8) { Array.new(8) }
    return unless fill_board
    place_pieces(:black)
    place_pieces(:red)
  end

  def on_board?(pos)
    row, col = pos
    row.between?(0,7) && col.between?(0,7)
  end

  def dup
    duped_board = Board.new(false)

    pieces.each do |piece|
      piece.class.new(piece.color, piece.pos.dup, duped_board)
    end

    duped_board
  end

  def pieces
    @rows.flatten.compact
  end

  def render
    system("clear")
    output = rows.map.with_index do |row, idx|
      row.map do |piece|
        # debugger if !piece.nil?
        piece.nil? ? "[ ]" : piece.symbol
      end.join(" ")
    end.join("\n")
    puts output
  end


end
