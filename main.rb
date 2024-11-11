require_relative "lib/chess_board"
require_relative "lib/chess_piece"

POS = 'D5'

arg = {'name' => 'knight', 'position' => POS, 'color' => "W", 'player' => "W"}
board = ChessBoard.new()
board.place_piece(arg)

# blockers
name = 'knight'
board.place_piece({'name' => name, 'position' => "B6", 'color' => "B", 'player' => "W"})
board.place_piece({'name' => name, 'position' => "F6", 'color' => "W", 'player' => "W"})
board.place_piece({'name' => name, 'position' => "C3", 'color' => "B", 'player' => "W"})
board.place_piece({'name' => name, 'position' => "E3", 'color' => "W", 'player' => "W"})

board.visualise(POS)
puts(board)


