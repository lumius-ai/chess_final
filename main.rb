require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require("pry-byebug")

# Captures response to a prompt
def prompt(str)
    puts(str)
    return gets().chomp
end

# Makes sure you entered two moves
def valid?(str)
    return str.split(" ").length == 2
end 

# Game loop
def main
    player_color = "x"
    
    while not ['b', 'w'].include?(player_color)
        player_color = prompt("Select your color").downcase
    end

    board = ChessBoard.new({'player' => player_color})
    # Continue until someone wins
    while board.is_mate.nil?
        puts(board)
        move = prompt("Make your move. Format: A1 A2. S to save game, L to load game, Q to quit")
        if move.upcase == 'S'
            board.save_game()
            puts("Game saved")
        elsif move.upcase == 'L'
            board = ChessBoard.load_game()
            puts("Game loaded")
        elsif move.upcase == 'Q'
            puts("bye")
            return
        # TEST
        elsif move.upcase == 'WK'
            p = board.select_piece(board.wking_pos)
            puts(p.moves)
        elsif not board.is_check().nil?
            puts("#{board.is_check().upcase} is in check")
            next
        elsif valid?(move)
            move = move.split(" ")
            board.move_piece(move[0].upcase, move[1].upcase)
        else
            puts("Invalid input")
        end 
    end
    puts("WINNER: #{board.get_winner}")
    return
end

def testing()
    # b = ChessBoard.load_game()
    b = ChessBoard.new()

    # Problem section
    piece = b.select_piece(b.wking_pos)
    moves = b.get_king(b.wking_pos)
    moves = moves.map {|e| b.array_to_board(e)}

    mcopy = []
    moves.each {|m| mcopy.append(m)}

    mcopy.each do |move|
        p = b.select_piece(move)
        # binding.pry
        if p.class == ChessPiece and p.color == piece.color
          moves.delete(move)
        end
      end

    puts(moves)
    # puts(b.select_piece(b.wking_pos).moves)

    b.visualise(b.wking_pos)
    b.visualise(b.bking_pos)

    puts(b)
end

testing()












