require_relative "lib/chess_board"
require_relative "lib/chess_piece"


king = {'name' => 'king', 'position' => "E1", 'color' => "W"}
king2 = {'name' => 'king', 'position' => "E8", 'color' => "B"}

rook = {'name' => 'rook', 'position' => "A2", 'color' => "B"}
knight = {'name' => 'knight', 'position' => "E4", 'color' => "B"}
bishop = {'name' => 'bishop', 'position' => "G4", 'color' => "B"}


# Black to move King in check
board = ChessBoard.new({'current_player' => 'b'})
board.clear()
board.place_piece(king)
board.place_piece(king2)
board.place_piece(rook)
board.place_piece(knight)
board.place_piece(bishop)
puts(board)

o = ChessBoard.copy(board)
puts(o)










