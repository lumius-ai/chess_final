require_relative("../lib/chess_coords")


include ChessCoords

describe "chess_coords" do
  describe "board to array" do
    it "converts A8 to [0, 0]" do
      expect(board_to_array("A8")).to eql([0, 0])
    end

    it "converts C4 to [4, 2]" do
      expect(board_to_array("C4")).to eql([4, 2])
    end

    it "converts H1 to [8, 8]" do
      expect(board_to_array("H1")).to eql([7, 7])
    end

    it "retruns nil on wrong length" do
      expect(board_to_array("AA1")).to eql(nil)
    end

    it "returns nil on wrong column" do
      expect(board_to_array("X1")).to eql(nil)
    end

    it "returns nil on wrong row" do
      expect(board_to_array("A9")).to eql(nil)
    end


  end

  describe "array to board" do

    it "converts [0, 0] to A8" do
      expect(array_to_board([0, 0])).to eql("A8")
    end

    it "converts [4, 2] to C4" do
      expect(array_to_board([4, 2])).to eql("C4")
    end

    it "converts [8, 8] to H1" do
      expect(array_to_board([7, 7])).to eql("H1")
    end

    it "retruns nil on wrong length" do
      expect(array_to_board([7, 7, 7])).to eql(nil)
    end

    it "returns nil on wrong column" do
      expect(array_to_board([-1, 7])).to eql(nil)
    end

    it "returns nil on wrong row" do
      expect(array_to_board([7, 9])).to eql(nil)
    end
  end
end