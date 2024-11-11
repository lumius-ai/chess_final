# Represents a chess piece

require_relative('chess_coords')

class ChessPiece
  attr_reader :icon, :color, :name
  attr_accessor :position, :moves

  include ChessCoords

  @@WHITE_PIECES = {
    'pawn' => "♟",
    'knight' => "♞",
    'bishop' => "♝",
    'rook' => "♜",
    'queen' => "♛",
    'king' => "♚",

  }

  @@BLACK_PIECES = {
    'pawn' => "♙",
    'knight' => "♘",
    'bishop' => "♗",
    'rook' => "♖",
    'queen' => "♕",
    'king' => "♔",
  }

  public
  # Constructor
  def initialize(args={})
    # Extract args
    args['color'].nil? ? @color = 'W' : @color = args['color']
    args['name'].nil? ? @name = 'pawn': @name = args['name']
    args['position'].nil? ? @position = 'E5' : @position = args['position']

    case @color.upcase
    when "W"
      @icon = @@WHITE_PIECES[@name]
    when "B"
      @icon = @@BLACK_PIECES[@name]
    else
      @icon = 'X'
    end
  end

  # To_string
  def to_s()
    return @icon
  end
  

end
