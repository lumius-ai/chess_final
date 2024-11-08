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

  #  "A8" => "00"
  def board_to_array(str)
    a = str.split("")
    out = {
      "row" => 8 - a[1].to_i,
      "column" => @@COLUMNS[a[0]]
    }
    return out
  end

  # "00" => "A8"
end