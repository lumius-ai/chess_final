# Represents a chess piece

require_relative('chess_coords')

require('json')

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
    args['moves'].nil? ? @moves = [] : @moves = args['moves']

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
  
  # Serialization
  def to_json(options = {})
    JSON.dump({
      :icon => @icon,
      :color => @color,
      :name => @name,
      :position => @position,
      :moves => @moves
    })
  end

  # Deserialization
  def self.from_json(serial_str)
    args = JSON.load(serial_str)
    p = ChessPiece.new(args)
    return p
  end

end
