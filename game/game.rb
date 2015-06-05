require 'gosu'
require './player.rb'
require './obstacle'
require './laser'

class GameWindow < Gosu::Window
  def initialize
    super 640, 480
    self.caption = "Gosu Tutorial Game"
    @background_image = Gosu::Image.new("media/Space.jpg", :tileable => true)
    @player = Ship.new
    @player.warp 320, 450

    @asteroids = []
    @astCounter = 0

    @backmusic = Gosu::Song.new(self, "media/Deeper.ogg")
    @backmusic.play(true)
  end

  def update
    @player.update(@asteroids)
    if @astCounter == 0
      @asteroids << Obstacle.new
      @astCounter += 1
    elsif @astCounter == 75
      @astCounter = 0
    else
      @astCounter += 1
    end
    @asteroids.each do |a|
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
    @asteroids.each do |a|
      a.draw
    end
  end
end

window = GameWindow.new
window.show