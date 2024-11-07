require_relative "lib/chess_board"
require_relative "lib/chess_piece"

board = ChessBoard.new()

board.place_piece(ChessPiece.new(), "A8")
puts(board)

board.move_piece("A8", "D7")
puts(board)