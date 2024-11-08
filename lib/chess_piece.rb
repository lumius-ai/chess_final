# Represents a chess piece

require_relative('chess_coords')


class ChessPiece
  attr_reader :icon, :color, :name
  attr_accessor :position, :Moves

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
      @icon = @@BLACK_PIECES[@name]
    when "B"
      @icon = @@WHITE_PIECES[@name]
    else
      @icon = 'X'
    end
  end

  # To_string
  def to_s()
    return @icon
  end

  # Clears valid moves and calculates all POSSIBLE (not necessarily valid) squares to go in. (Board notation)
  def update_moves()

  end


  private
  # Gets all diagonal squares relative to current position
  def get_diagonals()

  end

  # Gets the rook moves for a given position
  def get_cross()

  end

  # Gets all knight moves relative to a position
  def get_knight()

  end

  # Gets all adjacent tiles relative to the position
  def get_king()

  end

  # Gets all pawn moves relative to position
  def get_pawn()

  end


end
