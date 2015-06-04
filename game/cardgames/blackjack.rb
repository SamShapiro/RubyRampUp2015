require './bicycle.rb'

class Blackjack
	def initialize players, deck
		@players = players
		@deck = deck
	end

end

class BJackPlayer < Player
	def initialize name
		@name = name
		@hand = Hand.new
		@done = false
	end
	attr_reader :name
	attr_accessor :done
	def hit
		@hand.draw
	end

	def stand
		@done = true
	end

	def doubleDown
		@hand.draw()
		@done = true
	end

	def split
		@subOne = BJackPlayer.new(@name)
		@subOne.@hand.hand << @hand.hand.pop
	end

	def surrender
		@done = true
	end
end

deck = Deck.new

puts "Welcome to Blackjack! What is your name?"
name = gets.chomp.upcase
player = BJackPlayer.new(name)
dealer = BJackPlayer.new("Dealer")
for i in (0..5)
	deck.addDeck
end
deck.shuffle

players = [player, dealer]