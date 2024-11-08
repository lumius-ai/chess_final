# Module containing the functions to convert between chess board coordinates and array coordinates

module ChessCoords
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
    pre = str.split("")
    out = Array.new(2)

    out[0] = 8 - pre[1].to_i
    out[1] = ChessCoords::COLUMNS[pre[0]]

    return out
  end

  # Convert a 2 digit array into board notation
  # [0, 0]
  def array_to_board(arr)
    out = ""

    out += ChessCoords::COLUMNS.key(arr[1])
    out += (8 - arr[0].to_i)

    return out
  end

end