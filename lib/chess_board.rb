# Chess board
require_relative("chess_piece")
require_relative("chess_coords")

# TEST remove
require("pry-byebug")
class ChessBoard
  include ChessCoords

  attr_reader :current_player, :board, :player

  @@LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H"]
  @@PIECES = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]

  public
  # Constructor
  def initialize(args={})
    args['current_player'].nil? ? @current_player = "w" : @current_player = args['current_player']
    args['player'].nil? ? @player = 'W' : @player = args['player']

    @board = Array.new(8) {Array.new(8, '.')}

    # TEST undo this
    # @current_player.upcase() == 'W'? place_pieces('W') : place_pieces('B')

  end

  # To string
  def to_s
    r = 8
    outstr = "    A  B  C  D  E  F  G  H \n\n"
    @board.each do |row|
      outstr += "#{r.to_s}  "
      row.each do |element|
        outstr += (" #{element} ")
      end
      outstr += "  #{r.to_s}"
      r -= 1
      outstr += ("\n")
    
    end
    outstr += "\n    A  B  C  D  E  F  G  H \n"
    return outstr
  end
    
  # Moves piece from source to destination (in board format)
  def move_piece(source, destination)
    # Convert from board notation to array coords
    source_array = board_to_array(source)
    dest_array = board_to_array(destination)

    # TODO: Check if this is a valid move
    
    # Destination = source
    @board[dest_array[0]][dest_array[1]] = @board[source_array[0]][source_array[1]]
    # Update moved piece's postion and possible moves
    p = select_piece(destination)
    p.position = destination
    update_moves(p)
    # Source set to default
    @board[source_array[0]][source_array[1]] = "."

    # Other player's move now
    @current_player.upcase() == "W" ? @current_player = "b" : @current_player = "w"
  end

  # TEST REMOVE LATER
  def clear()
    @board = Array.new(8) {Array.new(8, '.')}
  end

  # All set all movable tiles to x
  def visualise(pos)
    piece = select_piece(pos)

    if piece == '.'
      return
    end

    piece.moves.each do |move|
      place_piece({'color' => 'X', 'position' => move})
    end
  end

  # Return piece at that tile
  def select_piece(pos)
    coord = board_to_array(pos)
    row = coord[0]
    col = coord[1]
    
    piece = @board[row][col]

    return piece
  end

  # Saves game state to JSON
  def save_game

  end

  # Loads game state from JSON
  def load_game

  end

  # private
  

  # Clears valid moves and calculates all POSSIBLE (not necessarily valid) squares to go in. (Board notation)
  def update_moves(piece)
    p = piece.position
    moves = []


    case piece.name
    when 'pawn'
      moves = get_pawn(p, @player, piece.color)

    when 'rook'
      moves = get_cross(p, @board)

    when 'knight'
      moves = get_knight(p)

    when 'bishop'
      moves = get_diagonals(p, @board)

    when 'queen'
      diags = get_diagonals(p, @board)
      cross = get_cross(p, @board)

      moves = diags + cross

    when 'king'
      moves = get_king(p)

    else
      moves = []
    end
    moves = moves.map {|e| array_to_board(e)}
    moves.delete(p)

    # update piece moves
    piece.moves = moves
  end

  # Create a specified piece and place it at the given position
  def place_piece(args={})
    args['name'].nil? ? name = "pawn" : name = args['name']
    args['color'].nil? ? color = "w" : color = args['color']
    args['position'].nil? ? position = "A8" : position = args['position']

    destination_array = board_to_array(position)
    piece = ChessPiece.new({'name' => name, 'color' => color, 'position' => position})

    row = destination_array[0]
    column = destination_array[1]

    # Place piece on board
    @board[row][column] = piece

    # Calculate its valid moves
    update_moves(piece)
    
  end
  
  # Places all pieces according to who the initial player is
  def place_pieces(color)
    case color.upcase
    when 'W'
      for i in 0...@@LETTERS.length()
        c = "#{@@LETTERS[i]}"
        # Placing pawns in columns
        place_piece({'color' => 'B', 'name' => 'pawn', 'position' => (c + "7"), 'player' => 'W'})
        place_piece({'color' => "W", 'name' => "pawn", 'position' => (c + "2"), 'player' => 'W'})

        # Placing pieces in columns
        place_piece({'color' => "B", 'name' => @@PIECES[i], 'position' => (c + "8"), 'player' => 'W'})
        place_piece({'color' => "W", 'name' => @@PIECES[i], 'position' => (c + "1"), 'player' => 'W'})
      end
    when 'B'
      for i in 0...@@LETTERS.length()
        c = "#{@@LETTERS[i]}"
        # Placing pawns in columns
        place_piece({'color' => "W", 'name' => "pawn", 'position' => (c + "7"), 'player' => 'B'})
        place_piece({'color' => "B", 'name' => "pawn", 'position' => (c + "2"), 'player' => 'B'})

        # Placing pieces in columns
        place_piece({'color' => "W", 'name' => @@PIECES[i], 'position' => (c + "8"), 'player' => 'B'})
        place_piece({'color' => "B", 'name' => @@PIECES[i], 'position' => (c + "1"), 'player' => 'B'})
      end
    end
  end


  # Checks if destination is valid based on current player, takes array
  def destination_valid?(arr)
    piece = select_piece(array_to_board(arr))

    if piece == '.'
      return true
    elsif piece.color != @current_player
      return true
    else
      return false
    end

  end

  # TODO: test these
  # Checks if source coord is valid based on current player, takes array
  def source_valid?(arr)
    piece = select_piece(array_to_board(arr))

    if piece != '.' and piece.color == @current_player
      return true
    else
      return false
    end

  end

  # Return T if current player's king is in check
  def is_check?()

  end

  # Return T if current player's king is in checkmate
  def is_mate?()

  end

  # Serialization
  def to_json

  end

  # Deserialization
  def from_json

  end

end