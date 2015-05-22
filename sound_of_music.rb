myfavthings = ["cats", "ice cream", "s'mores", "a cozy bed", "steak"]

#def a_few_of things
#	first = rand(things.length)
#	puts "#{things[first].capitalize}!"
#	things.delete_at(first)
#	second = rand(things.length)
#	puts "#{things[second].capitalize}!"
#	puts "These are a few of my favorite things!"
#end

def a_few_of favthings
	things = []
	for e in favthings
		things << e
	end
	tota = rand(1..things.length)
	for x in 1..tota
		oneof = things[rand(things.length)]
		puts "#{oneof.capitalize}!"
		things.delete(oneof)
	end
	puts "These are a few of my favorite things!"
end
		
a_few_of myfavthings