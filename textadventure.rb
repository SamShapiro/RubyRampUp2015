puts """You’re a traveler on a long journey. After many miles, you 
come to a fork in the road. To the North is a small village.  To 
the East is dark cave. Which way do you go? North or East?"""

def goplace direction
	if direction == "north"
		puts "You approach the village. A band of Orcs comes out and kills you. The end."
	elsif direction == "east"
		puts "You enter the cave. You are eaten by a grue. The end."
	else
		puts "Sorry, you have to go either North or East. Which way do you go?"
		goplace(gets.chomp.downcase)
	end
end


direction = gets.chomp.downcase
goplace direction