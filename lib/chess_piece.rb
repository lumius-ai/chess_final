# Represents a chess piece

require_relative('chess_coords')

class ChessPiece
  attr_reader :icon, :color, :name
  attr_accessor :position, :moves

  include ChessCoords

  # B or W to indicate the color of pieces on the bottom
  @@player = "W"

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

    self.update_moves()
  end

  # To_string
  def to_s()
    return @icon
  end

  # Clears valid moves and calculates all POSSIBLE (not necessarily valid) squares to go in. (Board notation)
  def update_moves()
    p = @position
    case @name
    when 'pawn'
      @moves = get_pawn(p, @@player, @color)

    when 'rook'
      @moves = get_cross(p)

    when 'knight'
      @moves = get_knight(p)

    when 'bishop'
      @moves = get_diagonals(p)

    when 'queen'
      diags = get_diagonals(p)
      cross = get_cross(p)

      @moves = diags + cross

    when 'king'
      @moves = get_king(p)

    else
      @moves = []
    end
    @moves = @moves.map {|e| array_to_board(e)}
    @moves.delete(p)
  end

  # Set player global
  def self.set_player(str)
    @@player = str
  end

  private
  

end
