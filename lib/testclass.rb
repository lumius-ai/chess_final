require_relative("chess_piece")
require('yaml')
require('json')

# A test class to hold other classes

class TestContainer
  attr_accessor :name, :box
  
  def initialize
    @name = "bob"
    @box = []

    arg = {'name' => 'king', 'position' => POS, 'color' => "W", 'player' => "W"}
    arg2 = {'name' => 'queen', 'position' => POS, 'color' => "W", 'player' => "W"}

    box.append(ChessPiece.new(arg))
    box.append(ChessPiece.new(arg2))
  end

  def to_json(options = {})
    JSON.dump({
      :name => @name,
      :box => @box
    })
  end

  def self.deserialize(serial_str)
    return JSON.load(serial_str)
  end
end