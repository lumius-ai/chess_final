require_relative("../lib/chess_board")
require_relative("../lib/chess_piece")
require_relative("../lib/chess_coords")


describe "ChessBoard"  do
  POS = 'D5'

  arg = {'name' => 'knight', 'position' => POS, 'color' => "W", 'player' => "W"}
  board = ChessBoard.new()
  board.place_piece(arg)

  # blockers
  name = 'knight'
  board.place_piece({'name' => name, 'position' => "B6", 'color' => "B", 'player' => "W"})
  board.place_piece({'name' => name, 'position' => "F6", 'color' => "W", 'player' => "W"})
  board.place_piece({'name' => name, 'position' => "C3", 'color' => "B", 'player' => "W"})
  board.place_piece({'name' => name, 'position' => "E3", 'color' => "W", 'player' => "W"})

  describe "source_valid?" do

    it "rejects empty square as source" do
      
      expect(board.source_valid?("A8")).to eq(false)
    end

    it "rejects pieces not of the player's color as source" do

      expect(board.source_valid?("B6")).to eq(false)
    end

    it "accepts pieces of current player's color" do

      expect(board.source_valid?("D5")).to eq(true)
    end
  end

  describe "destination_valid?" do

    it "rejects sources matching destination" do
      expect(board.destination_valid?("D5", "D5")).to eq(false)
    end

    it "rejects valid destinations occupied by same color pieces" do
      expect(board.destination_valid?("D5", "F6")).to eq(false)
    end

    it "rejects invalid move destinations" do
      expect(board.destination_valid?("D5", "D6")).to eq(false)
    end

    it "accepts valid move destinations" do
      expect(board.destination_valid?("D5", "B6")).to eq(true)
    end
  end
end
