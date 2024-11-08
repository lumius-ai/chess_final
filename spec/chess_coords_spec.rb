require_relative("../lib/chess_coords")

describe "chess_coords" do
  describe "board to array" do
    it "converts A8 to [0, 0]" do
      expect(array_to_board("A8")).to eql([0, 0])
    end

    it "converts C4 to [4, 2]" do
      expect(array_to_board("C4")).to eql([4, 2])
    end

    it "converts H1 to [8, 8]" do
      expect(array_to_board("H1")).to eql([8, 8])
    end

  end

  describe "array to board" do

    it "converts [0, 0] to A8" do
      expect(board_to_array([0, 0])).to eql("A8")
    end

    it "converts [4, 2] to C4" do
      expect(board_to_array([4, 2])).to eql("C4")
    end

    it "converts [8, 8] to H1" do
      expect(board_to_array([8, 8])).to eql("H1")
    end
  end

end