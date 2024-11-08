# A chess piece 


class ChessPiece
  attr_reader :piece, :name, :color
  attr_accessor :position, :possible_moves

  WHITE_PIECES = {
    'pawn' => "♟",
    'knight' => "♞",
    'bishop' => "♝",
    'rook' => "♜",
    'queen' => "♛",
    'king' => "♚",

  }

  BLACK_PIECES = {
    'pawn' => "♙",
    'knight' => "♘",
    'bishop' => "♗",
    'rook' => "♖",
    'queen' => "♕",
    'king' => "♔",
  }


  def initialize(color = "W", name = "pawn", position = "A8")
    case color.upcase
    when "W"
      @piece = WHITE_PIECES[name]

    when "B"
      @piece = BLACK_PIECES[name]
    else
      @piece = "X"
    end
    @name = name
    @position = position
  end

  # Printable
  def to_s
    return @piece
  end
end