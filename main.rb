require_relative "lib/chess_board"
require_relative "lib/chess_piece"

POS = 'D5'

arg = {'name' => 'pawn', 'position' => POS, 'color' => "B", 'player' => "W"}
board = ChessBoard.new()
board.place_piece(arg)

# blockers
name = 'knight'
board.place_piece({'name' => name, 'position' => "C6", 'color' => "W", 'player' => "W"})
board.place_piece({'name' => name, 'position' => "E6", 'color' => "W", 'player' => "W"})
board.place_piece({'name' => name, 'position' => "C4", 'color' => "W", 'player' => "W"})
board.place_piece({'name' => name, 'position' => "E4", 'color' => "W", 'player' => "W"})

board.visualise(POS)
puts(board)


