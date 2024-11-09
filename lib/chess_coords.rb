# Module containing the functions to convert between chess board coordinates and array coordinates
require "pry-byebug"
module ChessCoords
  COLUMNS = {'A' => 0,
  'B' => 1,
  'C' => 2,
  'D' => 3, 
  'E' => 4,
  'F' => 5,
  'G' => 6,
  'H' => 7
  }

  # Convert a board notation position into a 2 digit row-column array
  def board_to_array(str)

    # Leave arrays untouched
    return str if str.class() == Array

    pre = str.split("")
    if not COLUMNS.has_key?(pre[0]) or pre[1].to_i < 0 or pre[1].to_i > 8 or pre.length != 2
      return nil
    end

    out = Array.new(2)

    out[0] = 8 - pre[1].to_i
    out[1] = ChessCoords::COLUMNS[pre[0]]

    return out
  end

  # Convert a 2 digit array into board notation
  # [0, 0]
  def array_to_board(arr)
    # Leave strings untouched
    return arr if arr.class() == String

    if arr.length != 2 or arr[0] < 0 or arr[0] > 7 or arr[1] < 0 or arr[1] > 7
      return nil
    end

    out = ""
    out += ChessCoords::COLUMNS.key(arr[1])
    out += (8 - arr[0].to_i).to_s()

    return out
  end

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

    moves.append(curr_pos)

    case mode
    # +1 +1 bottom right
    when 0
      if ((row + 1) > 7) or ((col + 1) > 7)
        return moves
      else
        moves += calc_diagonal(mode, array_to_board([row + 1, col + 1]))
      end

    # -1 -1 top left
    when 1
      if ((row - 1) < 0) or ((col - 1) < 0)
        return moves
      else
        moves += calc_diagonal(mode, array_to_board([row - 1, col - 1 ]))
      end
    
    # +1 -1 bottom left
    when 2
      if((row + 1) > 7) or ((col - 1) < 0)
        return moves
      else
        moves += calc_diagonal(mode, array_to_board([row + 1, col - 1 ]))
      end

    #-1 +1 top right
    when 3
      if((row - 1) < 0) or ((col + 1) > 7)
        return moves
      else
        moves += calc_diagonal(mode, array_to_board([row - 1, col + 1]))
      end
    end

    return moves
  end
end