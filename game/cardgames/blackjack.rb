require './bicycle.rb'

mlt = Deck.new

for i in (0..5)
	mlt.addDeck
end
mlt.shuffle
for c in mlt.deck 
	puts "#{c.value} of #{c.suit}"
end