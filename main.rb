require_relative "lib/chess_board"
require_relative "lib/chess_piece"

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
        if not board.is_check().nil?
            puts("You are in check")
        elsif valid?(move)
            move.split!(" ")
            board.make_move(move[0].upcase, move[1].upcase)
        elsif move.upcase == 'S'
            board.save_game()
            puts("Game saved")
        elsif move.upcase == 'L'
            board = ChessBoard.load_game()
            puts("Game loaded")
        elsif move.upcase == 'Q'
            puts("bye")
            return
        else
            puts("Invalid input")
        end 
    end
    puts("WINNER: #{board.get_winner}")
    return
end
main()
















