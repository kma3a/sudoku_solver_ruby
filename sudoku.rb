class Board
	attr_accessor :board, :game_board, :solved, :previous_board

	def initialize(board)
		@board = board.split("")
		@game_board = []
		@previous_board = []
	end

	def play
		create_board
		until is_solved?
			eleminiation
			if impossible?
				return "impossible"
			end
		end
		print_board
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
				row << cell.value unless cell.value.is_a?(Array)
			end
		end
		row
	end

	def get_col(col_num)
		col = []
		game_board.each do |cell| 
			if cell.col == col_num
				col << cell.value unless cell.value.is_a?(Array)
			end
		end
		col
	end

	def get_box(box_num)
		box = []
		game_board.each do |cell| 
			if cell.box == box_num
				box << cell.value unless cell.value.is_a?(Array)
			end
		end
		box
	end

	def is_solved?
		game_board.map{|cell| cell.value}.flatten.length == 81
	end

	def impossible?
		game_board.map{|x| x.value}.include?([])
	end

	def need_guess
		if previous_board == game_board.map {|cell| cell.value}
			return true
		end
		self.previous_board = game_board.map {|cell| cell.value}
		false
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


board = Board.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")
board.create_board
print board.eleminiation