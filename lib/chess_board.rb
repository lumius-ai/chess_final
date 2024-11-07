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

  def initialize(player = "w")
    @cur_move = 'w'
    @board = Array.new(8) {Array.new(8, ".")}

    letters = ["A", "B", "C", "D", "E", "F", "G", "H"]
    pieces = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]

    case player.upcase()

    when 'W'
      # Placing pawns

      for i in 0...letters.length()
        c = "#{letters[i]}"
        # Placing pawns in columns
        place_piece(ChessPiece.new("B", "pawn"), (c + "7"))
        place_piece(ChessPiece.new("W", "pawn"), (c + "2"))

        # Placing pieces in columns
        place_piece(ChessPiece.new("B", pieces[i]), (c + "8"))
        place_piece(ChessPiece.new("W", pieces[i]), (c + "1"))
      end
    when 'B'
      for i in 0...letters.length()
        c = "#{letters[i]}"
        # Placing pawns in columns
        place_piece(ChessPiece.new("W", "pawn"), (c + "7"))
        place_piece(ChessPiece.new("B", "pawn"), (c + "2"))

        # Placing pieces in columns
        place_piece(ChessPiece.new("W", pieces[i]), (c + "8"))
        place_piece(ChessPiece.new("B", pieces[i]), (c + "1"))
      end

    end

  end

  # Place a piece at given coord
  def place_piece(piece, coord) 

    pos1 = parse(coord)
    @board[pos1["row"]][pos1["column"]] = piece
  end


  # Move a piece from x to Y
  def move_piece(source, dest)
    source_coords = parse(source)
    dest_coords = parse(dest)

    # Destination = source
    @board[dest_coords["row"]][dest_coords["column"]] = @board[source_coords["row"]][source_coords["column"]]
    # Source set to default
    @board[source_coords["row"]][source_coords["column"]] = "."
  end

  # Display Board
  def to_s
    r = 8
    outstr = "+ A  B  C  D  E  F  G  H +\n"
    @board.each do |row|
      outstr += r.to_s
      row.each do |element|
        outstr += (" #{element} ")
      end
      outstr += r.to_s
      r -= 1
      outstr += ("\n")
    
    end
    outstr += "+ A  B  C  D  E  F  G  H +\n"
    return outstr
  end

  private
  # Parses a board coord into an array position dict
  def parse(str)
    a = str.split("")
    out = {
      "row" => 8 - a[1].to_i,
      "column" => @@COLUMNS[a[0]]
    }
    return out
  end


end