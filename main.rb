require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require "pry-byebug"

POS = 'D4'

arg = {'name' => 'pawn', 'position' => POS, 'color' => "B", 'player' => "W"}
board = ChessBoard.new()
board.place_piece(arg)
p = board.select_piece(POS)
board.visualise(POS)
puts(board)


