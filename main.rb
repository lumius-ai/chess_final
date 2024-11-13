require_relative "lib/chess_board"
require_relative "lib/chess_piece"


king = {'name' => 'king', 'position' => "E1", 'color' => "W"}
king2 = {'name' => 'king', 'position' => "E8", 'color' => "B"}

rook = {'name' => 'rook', 'position' => "D8", 'color' => "B"}
knight = {'name' => 'knight', 'position' => "E4", 'color' => "B"}
bishop = {'name' => 'bishop', 'position' => "G4", 'color' => "B"}

empty = {'board' => Array.new(8){Array.new(8, '.')}, 'wking_pos' => 'E1', 'bking_pos' => 'E8'}


# Black to move King in check
board = ChessBoard.new(empty)
board.place_piece(king)
board.place_piece(rook)
board.visualise("E1")
puts(board)













