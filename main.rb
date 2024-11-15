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
        elsif not board.is_check().nil? and valid?(move)
            move = move.split(" ")
            move = move.map {|m| m.upcase}

            # Move on a hypothetical board first
            fboard = ChessBoard.copy(board)
            fboard.move_piece(move[0], move[1])
            # Move for real if the hypothetical is out of check
            board.move_piece(move[0], move[1]) if fboard.is_check.nil?

        elsif valid?(move)
            move = move.split(" ")
            move = move.map {|m| m.upcase()}

            board.move_piece(move[0], move[1])
            puts("#{board.is_check} in check") if not board.is_check.nil?
        else
            puts("Invalid input")
        end 
    end
    puts(board)
    puts("WINNER: #{board.get_winner}")
    return
end

def testing()

end

main()












