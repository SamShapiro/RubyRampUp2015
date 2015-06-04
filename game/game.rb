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
    @asteroids = []
    @astCounter = 0
  end

  def update
    @player.update
    @player.hitAsteroid(@asteroids)
    if @astCounter == 0
      @asteroids << Obstacle.new
      @astCounter += 1
    elsif @astCounter == 175
      @astCounter = 0
    else
      @astCounter += 1
    end
    for a in @asteroids
      if a.x > 640 || a.x + a.astImage.height < 0 || a.y > 480 || a.y + a.astImage.width < 0
        @asteroids.delete(a)
      else
        a.update
      end
    end
  end

  def draw
  	@background_image.draw(0,0,0)
    @player.draw
    for a in @asteroids
      a.draw
    end
  end
end

window = GameWindow.new
window.show