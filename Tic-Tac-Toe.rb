
class Board
	def initialize
		@board = [[0,0,0],
				[0,0,0],
				[0,0,0]]
	end
end

class Player
	attr_reader :score
	attr_reader :player_moves
	attr_reader :name
	def initialize(name, symbol)
		@name = name
		@score = 0
		@symbol = symbol
		@player_moves = []
	end
	def choose(choice_x, choice_y)
		@player_moves << [choice_x, choice_y]
	end
	def score
		@score+=1
	end
end

class TicTacToe
	def initialize(board)
		@board = board
	end

	def choose(player, choice_x, choice_y)
		unless !is_choice_valid?(choice_x, choice_y)
			player.choose(choice_x, choice_y)
			@board.board[choice_x][choice_y] = player.symbol
			unless is_game_finished?(player)
				player.score
				puts "#{player.name} won!"
				puts "New Game?"
				#asks for new game
				##to be continued
			end
		else
			puts "Invalid choice!"
		end
	end

	private
		def is_choice_valid?(choice_x, choice_y)
			if choice_x > 3 || choice_y > 3 || choice_x < 0 || choice_y < 0
				return false
			elsif @board[choice_x][choice_y] != 0
				return false
			else
				return true
			end
		end

#finish algorithm to check for finished game
##to be continued

end