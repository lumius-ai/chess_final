# A chess piece 


class ChessPiece
  attr_reader :piece
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


  def initialize(color = "W", piece = "pawn")
    case color.upcase
    when "W"
      @piece = WHITE_PIECES[piece]
    when "B"
      @piece = BLACK_PIECES[piece]
    else
      @piece = "X"
    end

  end

  def get_valid_moves()

  end

  # Printable
  def to_s
    return @piece
  end
end