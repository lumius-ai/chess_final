require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require_relative("lib/testclass")

POS = 'D5'

arg = {'name' => 'king', 'position' => POS, 'color' => "W", 'player' => "W"}
board = ChessBoard.new()
board.to_json()





