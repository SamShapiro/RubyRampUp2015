myfavthings = ["cats", "ice cream", "s'mores", "a cozy bed", "steak"]

def a_few_of things
	first = rand(things.length)
	puts "#{things[first].capitalize}!"
	things.delete_at(first)
	second = rand(things.length)
	puts "#{things[second].capitalize}!"
	puts "These are a few of my favorite things!"
end

a_few_of myfavthings