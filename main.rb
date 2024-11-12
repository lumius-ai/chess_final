require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require_relative("lib/testclass")

POS = 'D5'

arg = {'name' => 'king', 'position' => POS, 'color' => "W", 'player' => "W"}
board = ChessBoard.new()
board.move_piece("G1", "F3")
board.move_piece("B8", "C6")
board.save_game()
board.move_piece("B1", "C3")
puts(board)

b2 = ChessBoard.load_game()
puts(b2)

# puts(s)






