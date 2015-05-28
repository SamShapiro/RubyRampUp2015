require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new("media/Space.jpg", :tileable => true)
  end

  def update
  end

  def draw
  	@background_image.draw(0,0,0)
  end
end

window = GameWindow.new
window.show