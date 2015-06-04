class Obstacle
	def initialize (x=rand(640), y = 0.0, small=false, angle=0)
		@astImage = Gosu::Image.new('media/Asteroid.png')
		@x = x
		@y = y
		@small=small
		@angle=angle
		@invinceCounter = 0
	end

	attr_reader :small, :x, :y, :invinceCounter, :astImage
	
	def update
		@x += Gosu::offset_x(@angle, 1)
		@y += Gosu::offset_y(@angle, -1)
		@invinceCounter += 1
	end

	def draw
		if @small == true
			@astImage.draw(@x,@y,1, 0.6,0.6)
		else
			@astImage.draw(@x, @y, 1)
		end
	end
end