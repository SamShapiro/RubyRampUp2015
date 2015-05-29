class Obstacle
	def initialize
		@astImage = Gosu::Image.new('media/Asteroid.png')
		@x = rand(640)
		@y = 0.0
	end

	def update
		@y += 1
	end

	def draw
		@astImage.draw(@x, @y, 1)
	end
end