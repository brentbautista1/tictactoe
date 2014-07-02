
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
			unless is_game_finished?(player, choice_x, choice_y)
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

	public
		def is_game_finished?(player, choice_x, choice_y)
			check_x = 0
			check_y = 0
			#checks for horizontal and vertical success
			player.player_moves.each do |move|
				if move[0] == choice_x
					check_x += 1
				end
				if move[1] == choice_y
					check_y += 1
				end
			end
			if check_x == 3 || check_y == 3
				return true
			else
				return false
			end
			#checks for diagonal win!
			unless ((choice_x == 0 || choice_x == 2) && (choice_y != 0 || choice_y != 2)) || (choice_x == 1 && choice_y == 1)
				return false
			else
				check_backslash = 0
				x = 0
				check_foreslash = 0
				player.player_moves.each do |move|
					if move[0] == move[1]
						check_backslash += 1
					elsif move[0] == 2-x && move[1] == x
						x += 1
						check_foreslash += 1
					end
				end
				if check_foreslash == 3 || check_backslash == 3
					return true
				else
					return false
				end
			end
		end
end

board = Board.new

puts 'Enter player 1 name: '
p1_name = gets.chomp
p1 = Player.new(p1_name, 'x')

puts 'Enter player 2 name: '
p2_name = gets.chomp
p2 = Player.new(p2_name, 'o')