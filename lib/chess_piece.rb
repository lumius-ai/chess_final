# Represents a chess piece

require_relative('chess_coords')

require("pry-byebug")

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
  # Gets all diagonal squares relative to current position
  def get_diagonals(pos)
    moves = []

    moves += calc_diagonal(0, pos)
    moves += calc_diagonal(1, pos)
    moves += calc_diagonal(2, pos)
    moves += calc_diagonal(3, pos)

    return moves
  end

  # Gets the rook moves for a given position
  def get_cross(pos)
    moves = []
    coords = board_to_array(pos)
    row = coords[0]
    column = coords[1]

    # Vertical tiles
    for i in row...8
      moves.append([i, column])
    end
    for i in 0...row
      moves.append([i, column])
    end
    # Horizontal tiles
    for i in column...8
      moves.append([row, i])
    end
    for i in 0...column
      moves.append([row, i])
    end
    return moves
  end

  # Gets all knight moves relative to a position
  def get_knight(pos)
    coord = board_to_array(pos)
    x = coord[0]
    y = coord[1]
    moves = []

    # From knights assignment
    moves.append([x - 1, y + 2]) if (x - 1) >= 0 and (y + 2) <= 7
    moves.append([x + 1, y + 2]) if (x + 1) <= 7 and (y + 2) <= 7
    moves.append([x - 1, y - 2]) if (x - 1) >= 0 and (y - 2) >= 0

    moves.append([x + 1, y - 2]) if (x + 1) <= 7  and (y - 2) >= 0 #t
    moves.append([x + 2, y + 1]) if (x + 2) <= 7 and (y + 1) <= 7
    moves.append([x - 2, y + 1]) if (x - 2) >= 0 and (y + 1) <= 7

    moves.append([x + 2, y - 1]) if (x + 2) <= 7 and (y - 1) >= 0 #t
    moves.append([x - 2, y - 1]) if (x - 2) >= 0 and (y - 1) >= 0

    return moves

  end

  # Gets all adjacent tiles relative to the position
  def get_king(pos)
    coords = board_to_array(pos)
    row = coords[0]
    column = coords[1]
    moves = []

    # All adjacent tiles that exist
    moves.append([row + 1, column]) if (row + 1) < 8
    moves.append([row - 1, column]) if (row - 1) >= 0

    moves.append([row, column + 1]) if (column + 1) < 8
    moves.append([row, column - 1]) if (column - 1) >= 0


    moves.append([row + 1, column + 1]) if (row + 1) < 8 and (column + 1) < 8
    moves.append([row - 1, column - 1]) if (row - 1) >= 0 and (column - 1) >= 0

    moves.append([row - 1, column + 1]) if (row - 1) >= 0 and (column + 1) < 8
    moves.append([row + 1, column - 1]) if (row + 1) < 8 and (column - 1) >= 0

    return moves

  end

  # Gets all pawn moves relative to position
  def get_pawn(pos, player, color)
    moves = []
    coords = board_to_array(pos)
    row = coords[0]
    column = coords[1]


    # TEST
    # binding.pry

    case player.upcase()  
    when "W"
      if color == 'W'
        moves.append([row - 1, column]) if (row - 1) >= 0
        moves.append([row - 1, column - 1]) if (row - 1) >= 0 and (column - 1) >= 0
        moves.append([row - 1, column + 1]) if (row - 1) >= 0 and (column + 1) < 8


      else
        moves.append([row + 1, column]) if (row + 1) < 8
        moves.append([row + 1, column + 1]) if (row + 1) < 8 and (column + 1) < 8
        moves.append([row + 1, column - 1]) if (row + 1) < 8 and (column - 1) >= 0
      end

    when "B"
      if color == 'W'
        moves.append([row + 1, column]) if (row + 1) < 8
        moves.append([row + 1, column + 1]) if (row + 1) < 8 and (column + 1) < 8
        moves.append([row + 1, column - 1]) if (row + 1) < 8 and (column - 1) >= 0
      else
        moves.append([row - 1, column]) if (row - 1) >= 0
        moves.append([row - 1, column - 1]) if (row - 1) >= 0 and (column - 1) >= 0
        moves.append([row - 1, column + 1]) if (row - 1) >= 0 and (column + 1) < 8

      end
    end

    return moves
  end

  # Calculates possible tiles in a diagonal from current position
  def calc_diagonal(mode = 0, curr_pos)
    moves = []
    coord = board_to_array(curr_pos)
    row = coord[0]
    col = coord[1]

    case mode
    # +1 +1 bottom right
    when 0
      if ((row + 1) > 7) or ((col + 1) > 7)
        moves.append(curr_pos)
      else
        moves += calc_diagonal(array_to_board([row + 1, col + 1]))
      end

    # -1 -1 top left
    when 1
      if ((row - 1) < 0) or ((col - 1) < 0)
        moves.append(curr_pos)
      else
        moves += calc_diagonal(array_to_board([row - 1, col - 1 ]))
      end
    
    # +1 -1 bottom left
    when 2
      if((row + 1) > 7) or ((col - 1) < 0)
        moves.append(curr_pos)
      else
        moves += calc_diagonal(array_to_board([row + 1, col - 1 ]))
      end

    #-1 +1 top right
    when 3
      if((row - 1) < 0) or ((col + 1) > 7)
        moves.append(curr_pos)
      else
        moves += calc_diagonal(array_to_board([row - 1, col + 1]))
      end
    end

    return moves
  end

end
