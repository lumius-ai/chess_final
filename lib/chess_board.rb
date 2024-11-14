# Chess board
require_relative("chess_piece")
require_relative("chess_coords")

require("json")

# TEST remove
require("pry-byebug")

class ChessBoard
  include ChessCoords

  attr_reader :current_player, :board, :player, :wking_pos, :bking_pos

  @@LETTERS = ["A", "B", "C", "D", "E", "F", "G", "H"]
  @@PIECES = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]

  public
  # Constructor
  def initialize(args={})
    args['current_player'].nil? ? @current_player = "w" : @current_player = args['current_player']
    args['player'].nil? ? @player = 'W' : @player = args['player']
 
    if args['board'].nil?
      @board = Array.new(8) {Array.new(8, '.')}
      if @player.upcase() == 'W'
        @wking_pos = "E1"
        @bking_pos = "E8"
        place_pieces('W')
      else
        @wking_pos = "E8"
        @bking_pos = "E1"
        place_pieces('B')
      end 
    else
      @board = args['board']
      @wking_pos = args['wking_pos']
      @bking_pos = args['bking_pos']
    end


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

    # Check if this is a valid move
    if move_valid?(source, destination)
      # Destination = source
      @board[dest_array[0]][dest_array[1]] = @board[source_array[0]][source_array[1]]
      # Update moved piece's postion and possible moves
      p = select_piece(destination)
      p.position = destination
      
      # Source set to default
      @board[source_array[0]][source_array[1]] = "."
      update_all()
      # Other player's move now
      @current_player.upcase() == "W" ? @current_player = "b" : @current_player = "w"
      
      return 0
    else
      return 1
    end 
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
      row = board_to_array(move)[0]
      col = board_to_array(move)[1]
      @board[row][col].is_a?(ChessPiece) ? @board[row][col].icon = "X" : @board[row][col] = "X"
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
  def save_game()
    Dir.mkdir("sav") unless Dir.exist?("sav")
    if File.exist?("/sav/savegame.json")
      f = File.open("/sav/savegame.json", "w")
    else
      f = File.new("sav/savegame.json", "w")
    end
    data = self.to_json()
    f.write(data)
    f.close
  end


  # Loads game state from YAML
  def self.load_game
    if Dir.exist?("sav") and File.exist?("sav/savegame.json")
      f = File.open("sav/savegame.json", "r")
      obj = ChessBoard.from_json(f.read())
      return obj
    else
      return nil
    end
  end

  # private
  
  # Updates the moves of ALL pieces on the board
  def update_all()
    # Update all moves
    @board.each do |row|
      row.each do |tile|
        update_moves(tile)
      end
    end
  end

  # Clears valid moves and calculates all POSSIBLE (not necessarily valid) squares to go in. (Board notation)
  def update_moves(piece)
    if piece.class() == String
      return
    end

    p = piece.position
    moves = []


    case piece.name
    when 'pawn'
      moves = get_pawn(p, @player, piece.color, @board)

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
      piece.color == 'B'? @bking_pos = piece.position : @wking_pos = piece.position

    else
      moves = []
    end

    moves = moves.map {|e| array_to_board(e)}
    # Delete self and other pieces of the same color
    moves.delete(p)
    moves.each do |move|
      p = select_piece(move)

      if p.class == ChessPiece and p.color == piece.color
        moves.delete(move)
      end
    end

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
    update_all()
    check_filter()
    
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

  # Check if move from src to dst is valid
  def move_valid?(src, dst)
    return (source_valid?(src) and destination_valid?(src, dst))
  end

  # Checks if destination is valid based on current player, takes array
  def destination_valid?(src, dst)
    piece = select_piece(src)
    return (src != dst and piece.moves.include?(dst))
  end

  # Checks if source coord is valid based on current player, takes array
  def source_valid?(pos)
    piece = select_piece(pos)
    (piece.class() == ChessPiece and piece.color == @current_player.upcase()) ? true : false
  end

  # Return W if the white king is in check , B if the black king is in check, nil if no check
  def is_check()
    @board.each do |row|
      row.each do |e|
        if e.class == ChessPiece
          if e.color.upcase() == 'B' and e.moves.include?(@wking_pos)
            return 'W'
          elsif e.color.upcase() == 'W' and e.moves.include?(@bking_pos)
            return 'B'
          end
        end
      end
    end
    return nil
  end

  # Return T if current player's king is in checkmate
  def is_mate()
    black = self.select_piece(@bking_pos)
    white = self.select_piece(@wking_pos)

    # binding.pry

    if self.is_check() == 'B' and black.moves == []
      return 'B'
    elsif self.is_check() == 'W' and white.moves == []
      return 'W'
    else
      return nil
    end
  end

  # Serialization
  def to_json(options={})
    JSON.dump(
      {
        :current_player => @current_player,
        :board => @board,
        :player => @player,
        :wking_pos => @wking_pos,
        :bking_pos => @bking_pos

      }
    )
  end

  # Deserialization
  def self.from_json(serial_str)
    args = JSON.load(serial_str)
    board = args['board']
    
    board.map! do |row|
      row.map! do |element|
        if not element.is_a?(String)
          ChessPiece.new(element)
        else
          '.'
        end
      end
    end
    args['board'] = board

    return ChessBoard.new(args)
  end

  # Copy object
  def self.copy(chessboard)
    return ChessBoard.from_json(chessboard.to_json)
  end

  
  # For each piece on the board, filter out moves that would result in checkmate
  def check_filter()
    # original
    hboard = ChessBoard.copy(self)
    # Iterate through elements
    hboard.board.each do |row|
      row.each do |e|
        if e.is_a?(ChessPiece)
          # copy moves into distinct array
          mcopy = Array.new()
          e.moves.each {|m| mcopy.append(m)}
          # Get the real piece(from real board)
          real_piece = self.select_piece(e.position)

          # Filter all moves that would lead to self check
          mcopy.each do |m|
            tmp = hboard.select_piece(m)
            hboard.force_move(e.position, m)
            real_piece.moves.delete(m) if hboard.is_check() == e.color()
            # restore original state
            hboard.force_move(m, real_piece.position)
            # restore piece
            if tmp == '.'
              hboard.board[board_to_array(m)[0]][board_to_array(m)[1]] = '.'
            else
              hboard.board[board_to_array(m)[0]][board_to_array(m)[1]] = tmp
            end
          end
        end
      end
    end
    # binding.pry
  end

  # Moves piece without checking validity
  def force_move(source, destination)
    # Convert from board notation to array coords
    source_array = board_to_array(source)
    dest_array = board_to_array(destination)


    # Destination = source
    @board[dest_array[0]][dest_array[1]] = @board[source_array[0]][source_array[1]]
    # Update moved piece's postion and possible moves
    p = select_piece(destination)
    p.position = destination
      
    # Source set to default
    @board[source_array[0]][source_array[1]] = "."
    update_all()
    # Other player's move now
    @current_player.upcase() == "W" ? @current_player = "b" : @current_player = "w"
      
  end

  # Get all pieces on the board
  def get_pieces(board)
    p = []

    board.each do |row|
      row.each do |e|
        if e.is_a?(ChessPiece)
          p.append(e)
        end
      end
    end
    return p
  end
end