class Board
	attr_accessor :board, :game_board, :solved, :previous_board

	def initialize(board)
		@board = board.split("")
		@game_board = []
		@previous_board = []
	end

	def play!
		play
		print_board
	end

	def play
		create_board
		until is_solved?
			eleminiation
			impossible_brute
		end
		game_board
	end

	def impossible_brute
		if impossible?
				return false
		elsif need_guess
				brute_squad
		end
	end

	def create_board
		board.each_with_index do |num,index|
			game_board << create_cell(num, index)
		end
	end

	def create_cell(num, index)
		if num == "0"
			Cell.new({row: find_row(index), col: find_col(index), box: find_box(index)})
		else
			Cell.new({row: find_row(index), col: find_col(index), box: find_box(index), value: num.to_i})
		end
	end

	def find_row(index)
		index/ 9 + 1
	end

	def find_col(index)
		index % 9 + 1
	end

	def find_box(index)
		grid = [1,1,1,2,2,2,3,3,3,
						1,1,1,2,2,2,3,3,3,
						1,1,1,2,2,2,3,3,3,
					  4,4,4,5,5,5,6,6,6,
					  4,4,4,5,5,5,6,6,6,
					  4,4,4,5,5,5,6,6,6,
					  7,7,7,8,8,8,9,9,9,
					  7,7,7,8,8,8,9,9,9,
					  7,7,7,8,8,8,9,9,9]
		grid[index]				  
	end

	def print_board
		board = game_board.map {|cell| cell.value}
	end

	def eleminiation
		game_board.each_with_index do |cell,index|
			update_cell(index)
		end
	end

	def update_cell(index)
		if game_board[index].value.is_a?(Array)
			game_board[index].control(get_array_of_all(index))
		end
		game_board[index].value
	end

	def get_array_of_all(index)
		(get_row(game_board[index].row) + get_col(game_board[index].col) + get_box(game_board[index].box) ).uniq.sort
	end

	def get_row(row_num)
		row = []
		game_board.each do |cell| 
			if cell.row == row_num
				row << unless_array(cell)
			end
		end
		row.compact
	end

	def get_col(col_num)
		col = []
		game_board.each do |cell| 
			if cell.col == col_num
				col << unless_array(cell)
			end
		end
		col.compact
	end

	def get_box(box_num)
		box = []
		game_board.each do |cell| 
			if cell.box == box_num
				box << unless_array(cell)
			end
		end
		box.compact
	end

	def unless_array(cell)
		cell.value unless cell.value.is_a?(Array)
	end

	def is_solved?
		game_board.map{|cell| cell.value}.flatten.length == 81
	end

	def impossible?
		game_board.map{|x| x.value}.include?([])
	end

	def need_guess
		if previous_board == game_board.map {|cell| cell.value}
			true
		else
			self.previous_board = game_board.map {|cell| cell.value}
			false
		end
	end

	def brute_squad
		brute_board = game_board
		index = brute_board.index {|index| index.value.is_a?(Array) && index.value.length == 2}
		guess_1 = brute_board[index].value.shift
		guess_2 = brute_board[index].value.pop
		solution = try_guess(brute_board, index, guess_1)
		if solution
			self.game_board = solution
		else
			solution = try_guess(brute_board, index, guess_2)
		end
	end

	def try_guess(brute_board, index, guess)
		brute_board[index].value = guess
		board = brute_board.map { |num| num.value}
		self.class.new(board.map{|cell| cell.is_a?(Array) ? cell = 0 : cell}.join).play
	end	

end







class Cell
	attr_accessor :value
	attr_reader :row, :col, :box

	def initialize(arg)
		@row = arg.fetch(:row)
		@col = arg.fetch(:col)
		@box = arg.fetch(:box)
		@value = arg.fetch(:value, (1..9).to_a)
	end

	def control(array)
		delete_array_value(array)
		check_if_one
	end

	def delete_array_value(num_array)
	 	self.value -= num_array
	end

	def check_if_one
		if check_value
			change_value
		end
	end

	def change_value
		if value.is_a?(Array) && value.length == 1
			self.value = value[0]
		end
	end

	def is_array?
		value.is_a? Array
	end

	def check_value
		value.length == 1
	end

end


class Controller
	attr_accessor :input

	def initialize(param)
		@input = param
	end

	def solve
		if check_params && is_not_nil? && check_length
			board = Board.new(input).play!
			Views::BoardView.render(board)
		else
			Views::Error.render
		end
	end

	def check_params
		if input.match(/\D/)
			return false
		end
		true
	end

	def is_not_nil?
		if input == ""
			return false
		end
		true
	end

	def check_length
		unless input.length == 81
			return false
		end
		true
	end


	# def error_message
	# 	"input must contain no punctuation, letters or spaces"
	# end

end

module Views
	class Error
		def self.render
			"input must contain no punctuation, letters or spaces and equal 81"
		end
	end

	class BoardView
		def self.render(input)
			board = input.map{|x| x.is_a?(Array) ? " " : x }.each_slice(3).to_a.each_slice(3).to_a.each_slice(3).to_a
			board_string = "-------------\n"
			board_string << board_to_string(board)
			board_string
		end

		def self.board_to_string(board)
			board_string = ''
			board.each do |part|
				board_string << part_string(part) << "-------------\n"
			end
			board_string
		end

		def self.part_string(part)
			board_string = ''
			part.each do |line|
				line_str = "|"
				line_str << row_string(line)
				board_string << line_str << "\n"
			end
			board_string
		end

		def self.row_string(line)
			line_str = ''
			line.each do |triple|
				line_str << trip_string(triple) << "|"
			end
			line_str
		end

		def self.trip_string(triple)
			string = ""
			triple.each do |num|
				string << "#{num}"
			end
			string
		end

	end



end

con = Controller.new(ARGV[0])
puts con.solve


# # board = Board.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
# # p board.play

# # board_2 = Board.new("302609005500730000000000900000940000000000109000057060008500006000000003019082040")
# # p board_2.play
# # p board_2.print_board

# board_3 = Board.new("096040001100060004504810390007950043030080000405023018010630059059070830003590007")
# board_4 = Board.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
# board_5 = Board.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
# board_6 = Board.new("096040001100060004504810390007950043030080000405023018010630059059070830003590007")
# board_7 = Board.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
# board_8 = Board.new("005030081902850060600004050007402830349760005008300490150087002090000600026049503")
# board_9 = Board.new("290500007700000400004738012902003064800050070500067200309004005000080700087005109")
# board_10 = Board.new("080020000040500320020309046600090004000640501134050700360004002407230600000700450")
# board_11 = Board.new("608730000200000460000064820080005701900618004031000080860200039050000100100456200")
# board_12 = Board.new("370000001000700005408061090000010000050090460086002030000000000694005203800149500")
# board_13 = Board.new("000689100800000029150000008403000050200005000090240801084700910500000060060410000")
# board_14 = Board.new("030500804504200010008009000790806103000005400050000007800000702000704600610300500")
# board_15 = Board.new("000075400000000008080190000300001060000000034000068170204000603900000020530200000")
# board_16 = Board.new("300000000050703008000028070700000043000000000003904105400300800100040000968000200")
# board_17 = Board.new("302609005500730000000000900000940000000000109000057060008500006000000003019082040")

# # p board_3.play 
# # p board_4.play
# # p board_5.play
# # p board_6.play
# # p board_7.play
# # p board_8.play
# # p board_9.play
# # p board_10.play
# # p board_11.play
# # p board_12.play
# # p board_13.play!
# # p board_14.play!
# # p board_15.play!
# # p board_16.play!
# # p board_17.play!