require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require "pry-byebug"

board = ChessBoard.new()
board2 = ChessBoard.new("b")
puts(board)
puts(board2)