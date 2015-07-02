require_relative 'piece'
require 'byebug'

class Board

  attr_reader :rows

  def initialize
    @rows = Array.new(8) { Array.new(8) }
    make_starting_grid
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

  def place_pieces(color)
    @rows.each_with_index do |_, row_idx|
      row = color == :black ? [0, 1, 2] : [5, 6, 7]
      row.each do |idx|
        next if (row_idx + idx).even?
        Piece.new(color, [idx, row_idx], self)
      end
    end
  end

  def make_starting_grid
    place_pieces(:black)
    place_pieces(:red)
  end

  def on_board?(pos)
    pos = row, col
    row.between?(0,7) && col.between?(0,7)
  end

  def render
    system("clear")
    output = rows.map.with_index do |row, idx|
      row.map do |piece|
        # debugger if !piece.nil?
        piece.nil? ? "  " : piece.symbol
      end.join(" ")
    end.join("\n")
    puts output

end


end
