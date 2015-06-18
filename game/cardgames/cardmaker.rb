require 'gosu'
require './bicycle'

class CardMake < Gosu::Window
	def initialize card
		super 61, 90
		@background = Gosu::Image.new('media/whiteback.png')
		@cardfront = Gosu::Image.new('media/blankcard.png')
		@cardnum = Gosu::Image.from_text("#{card.value.to_s[0]}", 30)
		@cardsuit = Gosu::Image.new("media/#{card.suit}.png")
		@fullCard = self.record(61, 90) {
			@background.draw(0,0,0)
			@cardfront.draw(0,0,1, 0.0828804, 0.0857142)
			@cardnum.draw(21,15,2, 1, 1, Gosu::Color.argb(0xff_000000))
			@cardsuit.draw(20,57,2)
		}
	end

	attr_reader :fullCard
end