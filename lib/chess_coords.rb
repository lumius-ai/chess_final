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

  DEFAULT_BOARD = Array.new(8) {Array.new(8, '.')}
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
  def get_diagonals(pos, board)
    moves = []

    args = {
      mode:  0,
      board: board, 
      origin: pos,
      curr_pos: pos

    }

    for i in 0...4
      args[:mode] = i
      moves += calc_diagonal(args)
    end
    return moves
  end

  # Gets the rook moves for a given position
  def get_cross(pos, board)
    moves = []

    args = {
      mode:  0,
      board: board, 
      origin: pos,
      curr_pos: pos
    }
    for i in 0...4
      args[:mode] = i
      moves += calc_line(args)
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
  def get_king(pos, board=DEFAULT_BOARD)
    coords = board_to_array(pos)
    row = coords[0]
    column = coords[1]
    moves = []

    king = board.select_piece(pos)

    # All adjacent tiles that exist
    moves.append([row + 1, column]) if (row + 1) < 8
    moves.append([row - 1, column]) if (row - 1) >= 0

    moves.append([row, column + 1]) if (column + 1) < 8 #p
    moves.append([row, column - 1]) if (column - 1) >= 0


    moves.append([row + 1, column + 1]) if (row + 1) < 8 and (column + 1) < 8
    moves.append([row - 1, column - 1]) if (row - 1) >= 0 and (column - 1) >= 0

    moves.append([row - 1, column + 1]) if (row - 1) >= 0 and (column + 1) < 8
    moves.append([row + 1, column - 1]) if (row + 1) < 8 and (column - 1) >= 0 #p

    # special right castle
    if not king.is_moved()
      # Right rook relative to king
      r_rook = board[row, column + 3]
      if not r_rook.is_moved()
        # All tiles to the right of it
        args = {
          mode:  2,
          board: board, 
          origin: pos,
          curr_pos: pos
        }
        right_moves = calc_line(args)
        # Remove all occupied squares
        right_moves.union.each do |move|
          p = board[move[0], move[1]]
          if p.is_a?(ChessPiece) and not p == r_rook and not p == king
            # Invalid if there's a piece in the way
            return moves
          end
       end
      #  Append castle move if clear
       moves.append([row, column + 2])
      end

    end
    # special left castle
    if not king.is_moved()
      l_rook = board.select_piece(array_to_board([row, column - 4]))
      if not rlrook.is_moved()
        # All tiles to the right of it
        args = {
          mode:  3,
          board: board, 
          origin: pos,
          curr_pos: pos
        }
        left_moves = calc_line(args)
        # Remove all occupied squares
        left_moves.each do |move|
          p = board[move[0], move[1]]
          if p.is_a?(ChessPiece) and not p == r_rook and not p == king
            # Invalid if there's a piece in the way
            return moves
          end
       end
      #  Append castle move if clear
       moves.append([row, column - 2])
      end
    end

    return moves

  end

  # Gets all pawn moves relative to position
  def get_pawn(pos, player, color, board = DEFAULT_BOARD)
    moves = []
    coords = board_to_array(pos)
    piece = board.select_piece(pos)
    row = coords[0]
    column = coords[1]

    case player.upcase()  
    when "W"
      if color == 'W'
        moves.append([row - 1, column]) if (row - 1) >= 0

        moves.append([row - 1, column - 1]) if (row - 1) >= 0 and (column - 1) >= 0 and board[row - 1][column - 1] != '.'
        moves.append([row - 1, column + 1]) if (row - 1) >= 0 and (column + 1) < 8 and board[row - 1][column + 1] != '.'
        # Special move 2 squares forwards
        moves.append([row - 2, column]) if not piece.is_moved

      else
        moves.append([row + 1, column]) if (row + 1) < 8

        moves.append([row + 1, column + 1]) if (row + 1) < 8 and (column + 1) < 8 and board[row + 1][column + 1] != '.'
        moves.append([row + 1, column - 1]) if (row + 1) < 8 and (column - 1) >= 0 and board[row + 1][column - 1] != '.'
        # Special move 2 squares forwards
        moves.append([row + 2, column]) if not piece.is_moved
      end

    when "B"
      if color == 'W'
        moves.append([row + 1, column]) if (row + 1) < 8

        moves.append([row + 1, column + 1]) if (row + 1) < 8 and (column + 1) < 8 and board[row + 1][column + 1] != '.'
        moves.append([row + 1, column - 1]) if (row + 1) < 8 and (column - 1) >= 0 and board[row + 1][column - 1] != '.'
        # Special move 2 squares forwards
        moves.append([row + 2, column]) if (row + 2) < 8 and not piece.is_moved

      else
        moves.append([row - 1, column]) if (row - 1) >= 0

        moves.append([row - 1, column - 1]) if (row - 1) >= 0 and (column - 1) >= 0 and board[row - 1][column - 1] != '.'
        moves.append([row - 1, column + 1]) if (row - 1) >= 0 and (column + 1) < 8 and board[row - 1][column + 1] != '.'

        # Special move 2 squares forwards
        moves.append([row - 2, column]) if (row - 2) >= 0 and not piece.is_moved

      end
    end

    return moves
  end

  # Calculates possible tiles in a diagonal from current position
  def calc_diagonal(args={})
    mode = args[:mode]
    board = args[:board]
    origin = args[:origin]
    curr_pos = args[:curr_pos]
    
    moves = []
    coord = board_to_array(curr_pos)
    row = coord[0]
    col = coord[1]

    moves.append(curr_pos)

    case mode
    # +1 +1 bottom right
    when 0
      if ((row + 1) > 7) or ((col + 1) > 7) or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([row + 1, col + 1])
        moves += calc_diagonal(args)
      end

    # -1 -1 top left
    when 1
      if ((row - 1) < 0) or ((col - 1) < 0) or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([row - 1, col - 1])
        moves += calc_diagonal(args)
      end
    
    # +1 -1 bottom left
    when 2
      if((row + 1) > 7) or ((col - 1) < 0) or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([row + 1, col - 1])
        moves += calc_diagonal(args)
      end

    #-1 +1 top right
    when 3
      if((row - 1) < 0) or ((col + 1) > 7) or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([row - 1, col + 1])
        moves += calc_diagonal(args)
      end
    end

    args[:curr_pos] = args[:origin]
    return moves
  end

  # Calculates possible tiles in straight lines relative to position
  # def calc_line(mode=0, board=DEFAULT_BOARD, origin="A7", curr_pos)
  def calc_line(args={})
    mode = args[:mode]
    board = args[:board]
    origin = args[:origin]
    curr_pos = args[:curr_pos]

    moves = []

    coord = board_to_array(curr_pos)

    row = coord[0]
    col = coord[1]

    # Function
    moves.append(curr_pos)

    case mode

    # down
    when 0
      if (row + 1) > 7 or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([(row + 1), col])
        moves += calc_line(args)
      end
    # up
    when 1
      if (row - 1) < 0 or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([(row - 1), col])
        moves += calc_line(args)
      end
    # right
    when 2
      if (col + 1) > 7 or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([row, (col + 1)])
        moves += calc_line(args)
      end

    # left
    when 3

      if (col - 1) < 0 or (board[row][col] != '.' and curr_pos != origin)
        return moves
      else
        args[:curr_pos] = array_to_board([row, (col - 1)])
        moves += calc_line(args)
      end 
    end
    
    args[:curr_pos] = args[:origin]
    return moves
  end
end