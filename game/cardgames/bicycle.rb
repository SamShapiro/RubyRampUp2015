class Card
	def initialize (value, suit)
		@value = value
		@suit = suit
	end
	attr_reader :value
	attr_reader :suit
end

class Hand
	def initialize
		@hand = []
	end
	attr_reader :hand
	
end

class Deck
	def initialize
		@deck = []
		@suits = ["Spades", "Hearts", "Diamonds", "Clubs"]
		@nums = ["Ace"] + (2..10).to_a + ["Jack", "Queen", "King", "Ace"]
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
	def deal numplayers, handsize=1
		for i in handsize
			for hand in numplayers
				hand << @deck.pop
			end
		end
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