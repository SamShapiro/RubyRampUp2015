require 'gosu'
require './player.rb'
require './obstacle'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"
    @background_image = Gosu::Image.new("media/Space.jpg", :tileable => true)
    @player = Ship.new
    @player.warp 320, 450
    @asteroid = Obstacle.new
  end

  def update
    @player.update
    @asteroid.update
  end

  def draw
  	@background_image.draw(0,0,0)
    @player.draw
    @asteroid.draw
  end
end

window = GameWindow.new
window.show