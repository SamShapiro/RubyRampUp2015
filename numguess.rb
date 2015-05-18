num = rand(1..100)
def guesser random
	puts "I'm thinking of a number between 1 and 100. You have 5 guesses."
	gyes = false
	left = 5
	while left > 0
		puts "What's your guess?"
		guess = gets.chomp.to_i
		if guess > random
			puts "Sorry, that's too high. You have #{left-1} guesses left."
		elsif guess < random
			puts "Sorry, that's too low. You have #{left-1} guesses left."
		elsif guess == random
			puts "That's right, you got it!"
			gyes = true
			left = 0
		end
		left -= 1
	end
	if gyes
		puts "The correct answer was #{random}."
	end
end

guesser num