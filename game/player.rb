class Ship
  def initialize
    @playerImage = Gosu::Image.new("media/spaceship.png")
    @x = @y = @velx = @vely = @angle = 0.0
  end

  def warp x,y
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @velx += Gosu::offset_x(@angle, 0.5)
    @vely += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @velx
    @y += @vely
    @x %= 640
    @y %= 480

    @velx *= 0.95
    @vely *= 0.95
  end

  def draw
    @playerImage.draw_rot(@x, @y, 1, @angle)
  end

  def update
    if Gosu::button_down? Gosu::KbLeft
      self.turn_left
    end
    if Gosu::button_down? Gosu::KbRight
      self.turn_right
    end
    if Gosu::button_down? Gosu::KbUp
      self.accelerate
    end
    self.move
  end
end