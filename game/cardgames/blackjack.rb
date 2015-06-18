require './bicycle.rb'
require 'gosu'

class Blackjack < Gosu::Window

	def cardMake card
		background = Gosu::Image.new('media/blueback.png')
		cardfront = Gosu::Image.new('media/blankcard.png')
		cardsuit = Gosu::Image.new("media/#{card.suit}.png")
		return fullCard = self.record(61, 90) {
			background.draw(0,0,0, 0.4066666, 0.45)
			cardfront.draw(0,0,1, 0.0828804, 0.0857142)
			if card.value == 10
				@card_font.draw(card.value,14,15,2, 1, 1, Gosu::Color::BLACK)
			else
				@card_font.draw(card.value.to_s[0],21,15,2, 1, 1, Gosu::Color::BLACK)
			end
			cardsuit.draw(20,58,2)
		}
	end
	
	def initialize players, deck
		super 800, 550
		self.caption = "Welcome to Blackjack"
		@backgroundImage = Gosu::Image.new("media/casinotable.jpg", :tileable => true)
		@current_icon = Gosu::Image.new("media/curr_player.png")
		@players = players
		@bplayer = @players[0]
		@dealer = @players[1]
		@deck = deck
		@discard_pile = []
		@card_font = Gosu::Font.new(self, "Broadway", 30)
		@bust_font = Gosu::Font.new(self, "Algerian", 60)
		@font = Gosu::Font.new(self, "Arial", 20)
		@gameover = false
		@turnover = true
		@move_delay = 0
		@turn_delay = 30
		@end_delay = 250

		@bet_check = true

		@betting_pool = 1000
		@wager = 0
		@betting_turn = true

		@backmusic = Gosu::Song.new(self, "media/lounge_music.ogg")
		@backmusic.volume *= 0.2
    	@backmusic.play(true)
	end

	def dealer_turn
		while @dealer.score < 16
			@dealer.hit
		end
		@dealer.stand
	end

	def check_winner player
		@winner = "loses to"
		if !player.bust?
			if (player.score > @dealer.score) || @dealer.bust?
				@winner = "beats"
			elsif player.score == @dealer.score
				@winner = "pushes"
			end
			if player.blackjack?
				@winner = "beats"
			end
		end
	end

	def update
		@players.each do |player|
			player.update
		end
		if @move_delay > 0
			@move_delay -= 1
		end
		speed = 20
		if @deck.deck.size < 20
			4.times do
				@deck.addDeck
			end
		end
		if (Gosu::button_down? Gosu::KbSpace) || @end_delay == 0
			@turnover = true
			@betting_turn = true
			@end_delay = 250
		end
		if @turnover == false
			@players.each do |player|
				player.hand.hand.each do |card|
					if card.face == nil
						card.face = cardMake(card)
					end
					unless Gosu.distance(card.xpos, card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos) < speed/2
						card.xpos += Gosu::offset_x(Gosu.angle(card.xpos,card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos),speed)
						card.ypos += Gosu::offset_y(Gosu.angle(card.xpos,card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos),speed)
					end
					if Gosu.distance(card.xpos, card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos) > 1 && Gosu.distance(card.xpos, card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos) < speed/2
						card.xpos += Gosu::offset_x(Gosu.angle(card.xpos,card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos),1)
						card.ypos += Gosu::offset_y(Gosu.angle(card.xpos,card.ypos,player.xpos+(63*player.hand.hand.index(card)),player.ypos),1)
					end
				end
			end
		end
		unless @gameover
			if @turnover
				if @betting_turn
					if @wager > @betting_pool
						@wager = @betting_pool
					end
					if @wager < @betting_pool && @wager < 200 && (Gosu.button_down? Gosu::KbUp)
						@wager += 5
					end
					if @wager > 0 && (Gosu.button_down? Gosu::KbDown)
						@wager -= 5
					end
					if @wager > 0 && (Gosu.button_down? Gosu::KbD)
						@betting_pool -= @wager
						@betting_turn = false
					end
				else
					@bet_check = false
					@players.each do |player|
						if player.hand.hand.size > 0
							player.hand.hand.each do |card|
								if Gosu.distance(card.xpos, card.ypos, 50, 150) > speed/2
									card.xpos += Gosu::offset_x(Gosu.angle(card.xpos,card.ypos,50,150),speed)
									card.ypos += Gosu::offset_y(Gosu.angle(card.xpos,card.ypos,50,150),speed)
								else 
									@discard_pile << player.hand.hand.pop
								end
							end
						end
					end
					if @bplayer.hand.hand.size == 0 && @players[1].hand.hand.size == 0
						@deck.deal(@players,2)
						@players.each do |player|
							player.hand.hand.each do |card|
								card.face = cardMake(card)
							end
						end
						until @players.size == 2
							@players.delete_at(1)
						end
						@turnover = false
						@bplayer.done = false
						@dealer.done = false
						@turn_delay = 25
					end
				end
			else
				@dealer_turn = true
				for player in @players[0..-2]
					unless player.done || player.bust?
						@dealer_turn = false
					end
				end
				if @dealer_turn && !@dealer.done
					@bet_check = true
					if @turn_delay > 0
						@turn_delay -= 1
					else
						if @dealer.score < 17
							@dealer.hit
						else
							@dealer.stand
						end
					end
				end
				if (Gosu.button_down? Gosu::KbH) && !@bplayer.bust? && !@bplayer.done && @move_delay == 0
					@bplayer.hit
					@move_delay = 30
				elsif (Gosu.button_down? Gosu::KbH) && (@bplayer.bust? || @bplayer.done) && @players.size == 3 && @move_delay == 0
					if !@splayer.bust?
						@splayer.hit
						@move_delay = 30
					end
				end
				if (Gosu.button_down? Gosu::KbA)
					if !@bplayer.bust? && !@bplayer.done && @move_delay == 0
						@bplayer.stand
						@move_delay = 30
					elsif (@bplayer.done || @bplayer.bust?) &&@players.size == 3 && @move_delay == 0
						@splayer.stand
						@move_delay = 30
						@splayer.done = true
					end
				end
				if @bplayer.can_split? && @players.size == 2 && (Gosu.button_down? Gosu::KbL)
					@players.insert(1, BJackPlayer.new("Split", @deck.deck))
					@splayer = @players[1]
					@splayer.hand.hand << @bplayer.hand.hand.pop
					@deck.deal([@bplayer, @splayer])
					@betting_pool -= @wager
				end
			end
		end
		@win_update = true
		@players.each do |player|
			if !player.done
				@win_update = false
			end
		end
		if @betting_turn
			@win_update = false
		end
		if @win_update
			@end_delay -= 1
			@players[0..-2].each do |player|
				if @end_delay == 200
					check_winner(player)
					if @winner == "beats" && player.blackjack?
						@betting_pool += @wager*2.5
					elsif @winner == "beats"
						@betting_pool += @wager*2
					elsif @winner == "pushes"
						@betting_pool += @wager*1
					end
				end
			end
		end
	end

	def draw
		@backgroundImage.draw(0,0,0, 0.4210, 0.5)
		@font.draw("Cash Pool: $#{@betting_pool}", 50, 450, 2, 1, 1, Gosu::Color::WHITE)
		unless @betting_turn
			@font.draw("Wager: $#{@wager}", 50, 475, 2, 1, 1, Gosu::Color::WHITE)
		end
		unless @deck.deck.size == 0
			@deck.draw
		end
		@players.each do |player|
			if player.bust?
				@bust_font.draw("BUST",player.xpos+((player.hand.hand.size-2)*31), player.ypos+8, 3, 1.05, 1.05, Gosu::Color::BLACK)
				@bust_font.draw("BUST",player.xpos+((player.hand.hand.size-2)*31), player.ypos+10, 3, 1, 1, Gosu::Color::RED)
			end
			player.hand.hand.each_with_index do |card, index|
				if player.name == "Dealer" && index == 0 && !@dealer_turn
					@deck.draw(card.xpos, card.ypos)
				else
					if card.face == nil
						card.face = cardMake(card)
					end
					card.face.draw(card.xpos,card.ypos,1)
				end
			end
		end
		if @dealer_turn
			@current_icon.draw(285, 65, 4)
		elsif !@bplayer.done
			@current_icon.draw(285, 430, 4)
		elsif @players.size == 3 && !@players[1].done
			@current_icon.draw(285, 335, 4)
		end
		unless @discard_pile.size == 0
			@discard_pile[-1].face.draw(50,150,1)
		end

		if @betting_turn
			@font.draw("How much would you like to wager? #{@wager}", 240, 250, 2, 1, 1, Gosu::Color::WHITE)
		end

		@win_draw = true
		@players.each do |player|
			if !player.done || @betting_turn
				@win_draw = false
			end
		end

		if @win_draw
			@players[0..-2].each_with_index do |player, i|
				check_winner(player)
				pbust = ""
				dbust = ""
				if player.bust?
					pbust = " and bust"
				end
				if @dealer.bust?
					dbust = " and bust"
				end
				@message = "#{player.name}, with #{player.score} points#{pbust}, #{@winner} Dealer with #{@dealer.score} points#{dbust}."
				@font.draw(@message, 240, 250+(25*i),2,1,1,Gosu::Color::WHITE)
			end
		end
	end
end

class BJackPlayer < Player
	def initialize name, deck
		@name = name
		@hand = Hand.new
		@done = false
		@deck = deck
		@xpos = 325
		if @name == "Player"
			@ypos = 400
		elsif @name == "Dealer"
			@ypos = 35
		elsif @name == "Split"
			@ypos = 305
		end
		@hit_timer = 0
	end

	attr_reader :name, :xpos, :ypos
	attr_accessor :done

	def score
		aces = 0
		sum = 0
		@hand.hand.each do |card|
			case card.value
			when "Ace"
				sum += 11
				aces += 1
			when "Jack", "Queen", "King"
				sum += 10
			else
				sum += card.value
			end
		end
		while sum > 21 && aces > 0
			sum -= 10
			aces -= 1
		end
		sum
	end

	def bust?
		if self.score > 21
			true
			@done = true
		else
			false
		end
	end

	def hit
		if @hit_timer == 0
			self.draw(@deck)
			@hit_timer = 30
		end
	end

	def stand
		@done = true
	end

	def doubleDown
		self.draw(deck)
		@done = true
	end

	def can_split?
		if @hand.hand.size == 2 && @hand.hand[0].value == @hand.hand[1].value
			true
		else
			false
		end
	end

	def blackjack?
		if self.score == 21 && @hand.hand.size == 2
			true
		else
			false
		end
	end

	def surrender
		@done = true
	end

	def update
		if @hit_timer > 0
			@hit_timer -= 1
		end
	end
end

deck = Deck.new

player = BJackPlayer.new("Player", deck.deck)
dealer = BJackPlayer.new("Dealer", deck.deck)
for i in (0..5)
	deck.addDeck
end
deck.shuffle

players = [player, dealer]

window = Blackjack.new(players, deck)
window.show