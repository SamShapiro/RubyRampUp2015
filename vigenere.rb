def encrypt phrase, cipher, dir
	arphrase = phrase.gsub(/\W+/, '').upcase.split(//)
	arphrase.delete(" ")
	arcrypted = []
	arcipher = []
	letters = ("A".."Z").to_a.concat(("A".."Z").to_a)

	until arcipher.length >= arphrase.length
		for c in cipher.gsub(/\W+/, '').upcase.split(//)
			arcipher << c
			arcipher.delete(" ")
		end
	end

	until arcipher.length == arphrase.length
		arcipher.delete_at(-1)
	end
	for i in 0..arphrase.length-1
		numlet = letters.index(arphrase[i]).send(dir, letters.index(arcipher[i]))
		arcrypted << letters[numlet]
	end
	puts arcrypted.join('')
end


success = 0
until success == 1
	puts "This program uses a Vigenere Cipher. Would you like to ENCRYPT or DECRYPT a phrase?"
	cryption = gets.chomp
	if cryption.upcase == "ENCRYPT"
		puts "Enter your phrase to be encrypted:"
		ph = gets.chomp
		dir = "+"
		success = 1
	elsif cryption.upcase == "DECRYPT"
		puts "Enter your encoded phrase to be decrypted:"
		ph = gets.chomp
		dir = "-"
		success = 1
	else
		puts "You must enter a valid choice: ENCRYPT or DECRYPT. Please try again."
	end
end
puts "Enter the encryption key:"
ci = gets.chomp
encrypt ph, ci, dir