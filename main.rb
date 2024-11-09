require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require "pry-byebug"

board = ChessBoard.new()
board.move_piece("E7", "E6")
puts(board)


