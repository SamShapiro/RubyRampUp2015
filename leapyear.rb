def leapyear x,y
	leaps = []
	for year in x..y
		if year % 4 == 0 
			unless year % 100 == 0 && year % 400 != 0
				leaps << year
			end
		end
	end
	puts "Here are the leap years between the given years:"
	for i in leaps
		puts i
	end
end



puts "Please enter a starting year:"
y1 = gets.chomp.to_i
puts "Please enter an ending year:"
y2 = gets.chomp.to_i

leapyear y1,y2