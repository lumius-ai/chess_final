require_relative "lib/chess_board"
require_relative "lib/chess_piece"

POS = 'D5'

arg = {'name' => 'pawn', 'position' => POS, 'color' => "B", 'player' => "W"}
board = ChessBoard.new()
board.clear()
board.place_piece(arg)
board.visualise(POS)
puts(board)


