require 'gosu'

WIDTH = 640
HEIGHT= 480
TITLE = "Ruby Chess"

class ChessGame < Gosu::Window

  # Constructor
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = TITLE

    @background_image = Gosu::Image.new("media/space.jpg", :tileable => true)
  end

  # Game logic
  def update

  end

  # Visuals
  def draw
    @background_image.draw(0,0,0)

  end

  # Escape
  def button_down(id)
    if id == Gosu::KB_ESCAPE
      self.close()
    end
  end

end

ChessGame.new.show