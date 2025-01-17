# Represents a chess piece

require_relative('chess_coords')

require('json')

class ChessPiece
  # move icon to reader
  attr_reader :color, :name
  attr_accessor :position, :moves, :icon, :is_moved

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
    args['is_moved'].nil? ? @is_moved = false : @is_moved = args['is_moved']

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
      :moves => @moves,
      :is_moved => @is_moved
    })
  end

  # Deserialization
  def self.from_json(serial_str)
    args = JSON.load(serial_str)
    p = ChessPiece.new(args)
    return p
  end

end
