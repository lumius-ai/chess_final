require_relative "lib/chess_board"
require_relative "lib/chess_piece"


king2 = {'name' => 'king', 'position' => "E1", 'color' => "W"}
king = {'name' => 'king', 'position' => "E8", 'color' => "B"}

rook = {'name' => 'rook', 'position' => "A1", 'color' => "B"}
rook2 = {'name' => 'rook', 'position' => "C1", 'color' => "W"}

knight = {'name' => 'knight', 'position' => "E4", 'color' => "B"}
bishop = {'name' => 'bishop', 'position' => "G4", 'color' => "B"}

empty = {'board' => Array.new(8){Array.new(8, '.')}, 'wking_pos' => 'E1', 'bking_pos' => 'E8'}


board = ChessBoard.new(empty)
# black
board.place_piece(king)
board.place_piece(rook)


# white
board.place_piece(king2)
board.place_piece(rook2)

board.visualise("C1")
# board.visualise("E8")

puts(board)
# puts(board.select_piece(board.wking_pos).moves)















