require_relative "lib/chess_board"
require_relative "lib/chess_piece"

require "pry-byebug"

# board = ChessBoard.new()
# puts(board)

require("pry-byebug")

COLUMNS = {'A' => 0,
  'B' => 1,
  'C' => 2,
  'D' => 3, 
  'E' => 4,
  'F' => 5,
  'G' => 6,
  'H' => 7
  }

  # Convert a board notation position into a 2 digit row-column array
  def board_to_array(str)
    binding.pry
    pre = str.split("")
    out = Array.new(2)

    out[0] = 8 - pre[1].to_i
    out[1] = COLUMNS[pre[0]]

    return out
  end
  
  board_to_array("A8")
