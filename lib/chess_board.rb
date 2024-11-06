# Chess board for the game to be played
require_relative("../lib/chess_piece")

require "pry-byebug"

class ChessBoard
  attr_accessor :board, :cur_move

  @@COLUMNS = {'A' => 0,
    'B' => 1,
    'C' => 2,
    'D' => 3, 
    'E' => 4,
    'F' => 5,
    'G' => 6,
    'H' => 7
  }

  def initialize
    @cur_move = 'w'
    @board = Array.new(8) {Array.new(8, ".")}

    place_piece(ChessPiece.new(), "A8")

  end

  # Place a piece at given coord
  def place_piece(piece, coord)

    # DEBUG
    

    a = coord.split("")
    row = a[1].to_i % 8
    column = @@COLUMNS[a[0]]
    # binding.pry
    @board[row][column] = piece
  end


  # Move a piece from x to Y
  # Display Board
  def to_s
    r = 8
    outstr = " A  B  C  D  E  F  G  H\n"
    @board.each do |row|
      outstr += r.to_s
      row.each do |element|
        outstr += (" #{element} ")
      end
      outstr += r.to_s
      r -= 1
      outstr += ("\n")
    
    end
    outstr += " A  B  C  D  E  F  G  H\n"
    return outstr
  end
end