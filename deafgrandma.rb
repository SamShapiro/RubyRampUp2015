def grandma talk
	if talk != talk.upcase
		puts "HUH? SPEAK UP, SONNY!"
	elsif talk  == "BYE"
		puts "OH, DO YOU HAVE TO LEAVE SO SOON?"
	else
		puts "OH NO, NOT SINCE #{rand(1930..1980)}!"
	end
end

byes = 0
puts "HELLO DEARIE, IT'S YOUR DEAR OLD GRANDMA! SO GOOD TO SEE YOU!"
until byes == 3
	convo = gets.chomp
	if convo == "BYE"
		byes += 1
	else
		byes = 0
	end
	unless byes == 3
		grandma convo
	end
end