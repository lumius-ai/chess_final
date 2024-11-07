require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require "pry-byebug"

board = ChessBoard.new()

board.place_piece(ChessPiece.new(), "A8")
board.place_piece(ChessPiece.new(), "B7")
board.place_piece(ChessPiece.new(), "C6")
puts(board)

# puts(board)