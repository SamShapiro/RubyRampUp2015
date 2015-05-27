def decrypt phrase, cipher
	arphrase = phrase.upcase.split(//)
	arphrase.delete(" ")
	arcrypted = []
	arcipher = []
	letters = ("A".."Z").to_a
	for a in ("A".."Z").to_a
		letters << a
	end

	until arcipher.length >= arphrase.length
		for c in cipher.upcase.split(//)
			arcipher << c
			arcipher.delete(" ")
		end
	end

	until arcipher.length == arphrase.length
		arcipher.delete_at(-1)
	end
	for i in 0..arphrase.length-1
		numlet = letters.index(arphrase[i]) - letters.index(arcipher[i])
		arcrypted << letters[numlet]
	end
	puts arcrypted.join('')
end

puts "Enter your encoded phrase to be decrypted:"
ph = gets.chomp
puts "Enter the encryption key:"
ci = gets.chomp
decrypt ph, ci