
class Board
	attr_accessor :board
	def initialize
		@board = [[0,0,0],
				[0,0,0],
				[0,0,0]]
	end
	def display
		@board.each do |row|
			print "#{row}\n"
		end
	end 
end

class Player
	attr_reader :score
	attr_reader :player_moves
	attr_reader :name
	attr_reader :symbol
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

	private
		def is_choice_valid?(choice_x, choice_y)
			if choice_x != choice_x.to_i.to_s || choice_y != choice_y.to_i.to_s
				return false
			end
			if choice_x.to_i > 3 || choice_y.to_i > 3 || choice_x.to_i < 0 || choice_y.to_i < 0
				return false
			elsif @board.board[choice_x.to_i][choice_y.to_i] != 0
				return false
			else
				return true
			end
		end

	public
		def choose(player, choice_x, choice_y)
			unless !is_choice_valid?(choice_x, choice_y)
				choice_x = choice_x.to_i
				choice_y = choice_y.to_i
				player.choose(choice_x, choice_y)
				@board.board[choice_x][choice_y] = player.symbol
				return 1
			else
				puts "Invalid choice!"
				return 0
			end
		end

	public
		def check_status_of_game(player, choice_x, choice_y)
			is_game_finished?(player, choice_x.to_i, choice_y.to_i)
		end

	private
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
			end
			#checks for diagonal win!
			unless ((choice_x == 0 || choice_x == 2) && (choice_y == 0 || choice_y == 2)) || (choice_x == 1 && choice_y == 1)
				print "hello!"
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
game = TicTacToe.new(board)

puts 'Enter player 1 name: "x"'
p1_name = gets.chomp
p1 = Player.new(p1_name, 'x')

puts 'Enter player 2 name: "o"'
p2_name = gets.chomp
p2 = Player.new(p2_name, 'o')

game_status = false
i = 0

while !game_status
	board.display
	if i%2 == 0
		player = p1
	else
		player = p2
	end
	puts game_status
	puts "#{player.name}! Choose a move!"
	choice_x = gets.chomp
	choice_y = gets.chomp
	i += game.choose(player, choice_x, choice_y)
	game_status = game.check_status_of_game(player, choice_x, choice_y)
end

puts "Game is finished! #{player.name} won!"