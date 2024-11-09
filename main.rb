require_relative "lib/chess_board"
require_relative "lib/chess_piece"

POS = 'D4'

arg = {'name' => 'queen', 'position' => POS, 'color' => "W", 'player' => "W"}
board = ChessBoard.new()
board.place_piece(arg)
board.visualise(POS)
puts(board)


