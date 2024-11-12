require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require_relative("lib/testclass")

POS = 'D5'

arg = {'name' => 'king', 'position' => POS, 'color' => "W", 'player' => "W"}
board = ChessBoard.new()
piece = ChessPiece.new(arg)

s = board.to_json()

d = ChessBoard.from_json(s)

puts(s)
puts(d)





