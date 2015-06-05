class Ship
  def initialize
    @playerImage = Gosu::Image.new("media/spaceship.png")
    @lsound = Gosu::Sample.new("media/lasersound.wav")
    @x = @y = @velx = @vely = @angle = 0.0
    @lasers = []
    @laserCooldown = 0
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
    @lasers.each do |laser|
      laser.draw
    end
  end

  def shootLaser
    @lasers << Laser.new(@x, @y, @angle)
    @laserCooldown = 30
    @lsound.play
  end

  def update (asts)
    if Gosu::button_down? Gosu::KbSpace 
      if @laserCooldown < 1
        self.shootLaser
      end
    end
    if @laserCooldown > 0
      @laserCooldown -= 1
    end
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
    @lasers.each do |laser|
      laser.update (asts)
      if laser.hashit == true
        @lasers.delete(laser)
      end
    end
  end
end