# Chess board
require_relative("chess_piece")
require_relative("chess_coords")

class ChessBoard
  include ChessCoords

  attr_reader :current_player, :board

  @@LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H"]
  @@PIECES = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]

  public
  # Constructor
  def initialize(args={})
    args['current_player'].nil? ? @current_player = "w" : @current_player = args['current_player']

    @board = Array.new(8) {Array.new(8, '.')}

    @current_player.upcase() == 'W'? place_pieces('W') : place_pieces('B')

  end

  # To string
  def to_s
    r = 8
    outstr = "     A  B  C  D  E  F  G  H \n\n"
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
    
  # Moves piece from source to destination
  def move_piece(source, destination)
    # Convert from board notation to array coords
    source_array = board_to_array(source)
    dest_array = board_to_array(dest)

    # TODO: Check if this is a valid move
    
    # Destination = source
    @board[dest_array[0]][dest_array[1]] = @board[source_array[0]][source_array[1]]
    # Source set to default
    @board[source_array[0]][source_array[1]] = "."
  end

  # Saves game state to JSON
  def save_game

  end

  # Loads game state from JSON
  def load_game

  end

  private
  # Create a specified piece and place it at the given position
  def place_piece(name, color, position)
    destination_array = board_to_array(position)
    piece = ChessPiece.new(name, color, position)

    row = destination_array[0]
    column = destination_array[1]

    @board[row][column] = piece
    
  end


  # Places all pieces according to who the initial player is
  def place_pieces(color)
    case color.upcase
    when 'W'
      for i in 0...@@LETTERS.length()
        c = "#{@@LETTERS[i]}"
        # Placing pawns in columns
        place_piece(ChessPiece.new("B", "pawn", (c + "7")), (c + "7"))
        place_piece(ChessPiece.new("W", "pawn", (c + "2")), (c + "2"))

        # Placing pieces in columns
        place_piece(ChessPiece.new("B", @@PIECES[i], (c + "8")), (c + "8"))
        place_piece(ChessPiece.new("W", @@PIECES[i], (c + "1")), (c + "1"))
      end
    when 'B'
      for i in 0...@@LETTERS.length()
        c = "#{@@LETTERS[i]}"
        # Placing pawns in columns
        place_piece(ChessPiece.new("W", "pawn", (c + "7")), (c + "7"))
        place_piece(ChessPiece.new("B", "pawn", (c + "2")), (c + "2"))

        # Placing pieces in columns
        place_piece(ChessPiece.new("W", @@PIECES[i], (c + "8")), (c + "8"))
        place_piece(ChessPiece.new("B", @@PIECES[i], (c + "1")), (c + "1"))
      end
    end
  end


  # Checks if destination is valid based on current player
  def destination_valid?(coord)

  end

  # Checks if source coord is valid based on current player
  def source_valid?(coord)

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