require 'gosu'

class Card
	def initialize (value, suit)
		@value = value
		@suit = suit
		@face = nil
		@xpos = 50
		@ypos = 50
	end
	
	attr_reader :value, :suit
	attr_accessor :face, :xpos, :ypos
end

class Hand 
	def initialize 
		@hand = []
	end
	attr_accessor :hand
	
end

class Deck
	def initialize
		@deck = []
		@cardback = Gosu::Image.new("media/cardback.png")
		@suits = ["Spades", "Hearts", "Diamonds", "Clubs"]
		@nums = (2..10).to_a + ["Jack", "Queen", "King", "Ace"]
		for s in @suits
			for c in @nums
				@deck << Card.new(c, s)
			end
		end
	end

	def addDeck
		for s in @suits
			for c in @nums
				@deck << Card.new(c, s)
			end
		end
	end
	attr_reader :deck
	def shuffle
		@deck.shuffle!
	end
	def deal players, handsize=1
		for i in (0...handsize)
			for player in players
				player.hand.hand << @deck.pop
			end
		end
	end

	def draw (xpos=50,ypos=50)
		@cardback.draw(xpos,ypos,2, 0.75, 0.75)
	end
end

class Player 
	def initialize name
		@name = name
		@hand = Hand.new
	end	

	def draw deck, numdraw=1
		for i in (0...numdraw)
			@hand.hand << deck.pop
		end
	end
	attr_reader :name
	attr_reader :hand
end