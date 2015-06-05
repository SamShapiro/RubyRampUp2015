class Laser
	def  initialize (x = 0, y = 0, angle = 0)
		@laserImage = Gosu::Image.new("media/laser.png")
		@x = x
		@y = y
		@angle = angle
		@hashit = false
    @smash = Gosu::Sample.new("media/smash.wav")
	end

	attr_reader :hashit

	def hitAsteroid(asts)
    	asts.each do |a|
      		if Gosu::distance(@x, @y, a.x+a.astImage.width/2, a.y+a.astImage.height/2) < 25 && a.invinceCounter > 30
        		@smash.play
        		if a.small == false
          			asts << Obstacle.new(x=a.x, y=a.y,small=true, angle=rand(360))
          			asts << Obstacle.new(x=a.x, y=a.y,small=true, angle=rand(360))
          			asts << Obstacle.new(x=a.x, y=a.y,small=true, angle=rand(360))
          			asts.delete(a)
        		else
          			asts.delete(a)
        		end
        		@hashit = true
      		end
    	end
  	end

  	def update (asts)
      self.hitAsteroid(asts)
  		@x += Gosu::offset_x(@angle, 8)
  		@y += Gosu::offset_y(@angle, 8)
  	end

  	def draw
  		@laserImage.draw_rot(@x, @y, 1, @angle)
  	end

end