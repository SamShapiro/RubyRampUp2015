bottles = 99
while bottles > 0
	puts """#{bottles} bottles of beer on the wall!
#{bottles} of beer!
Take one down, pass it around, #{bottles-1} bottles of beer on the wall!"""
	puts ""
	bottles -= 1
	sleep(1)
end	