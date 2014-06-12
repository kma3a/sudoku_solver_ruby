require_relative "sudoku"

describe Board do
	let(:board) {Board.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")}
	let(:board_2) {Board.new("182345740050008019010000000800005000000804000000300006000000070030500080972400050")}
	let(:board_3) {Board.new("000689100800000029150000008403000050200005000090240801084700910500000060060410000")}

	context '#initialize' do
		it "creates a Board object" do
			expect(board).to be_an_instance_of(Board)
		end

		it "requires parameters" do
			expect{Board.new}.to raise_error(ArgumentError)
		end
	end

	context '#board' do
		 it "expect board to have a length of 81" do
		 	expect(board.board.length).to eq(81)
		 end

		 it "should be an array" do
		 	expect(board.board.is_a?(Array)).to eq(true)
		 end
	end

	context '#previous_board' do
		it "should be empty" do
			board.create_board
			expect(board.previous_board).to eq([])
		end
	end

	context '#find_row' do
		it 'should give the row with a givin index' do
			expect(board.find_row(25)).to eq(3)
		end

		it 'another test to be sure the row is right' do
			expect(board.find_row(4)).to eq(1)
		end

		it 'should pass this last test too' do
			expect(board.find_row(78)).to eq(9)
		end
	end

	context '#find_col' do
		it 'should give the col with a givin index' do
			expect(board.find_col(25)).to eq(8)
		end

		it 'another test to be sure the col is right' do
			expect(board.find_col(4)).to eq(5)
		end

		it 'should pass this last test too' do
			expect(board.find_col(78)).to eq(7)
		end
	end

	context '#find_box' do
		it 'should give the box with a givin index' do
			expect(board.find_box(25)).to eq(3)
		end

		it 'another test to be sure the box is right' do
			expect(board.find_box(4)).to eq(2)
		end

		it 'should pass this last test too' do
			expect(board.find_box(78)).to eq(9)
		end
	end

	context '#game_board' do
		it 'should start blank' do
			expect(board.game_board).to eq([])
		end
	end

	context '#create_board' do
		it 'should add to game_board' do
			board.create_board
			expect(board.game_board.length).to eq(81)
		end
	end

	context '#create_cell' do
		it 'should create a cell' do
			expect(board.create_cell("1", 2)).to be_an_instance_of(Cell)
		end

		it 'should create a cell without a value if number is "0"' do
			expect(board.create_cell("0",2).value).to eq((1..9).to_a)
		end

		it 'should create a cell with a value if number is a number' do
			expect(board.create_cell("6",2).value).to eq(6)
		end
	end

	context '#play!' do
		it 'should solve the board' do
			expect(board.play!).to eq([1, 4, 5, 8, 9, 2, 6, 7, 3, 8, 9, 3, 1, 7, 6, 4, 2, 5, 2, 7, 6, 4, 3, 5, 8, 1, 9, 5, 1, 9, 2, 4, 7, 3, 8, 6, 7, 6, 2, 5, 8, 3, 1, 9, 4, 3, 8, 4, 9, 6, 1, 7, 5, 2, 9, 5, 7, 6, 1, 4, 2, 3, 8, 4, 3, 8, 7, 2, 9, 5, 6, 1, 6, 2, 1, 3, 5, 8, 9, 4, 7])
		end

		# it 'should return impossible if impossible' do
		# 	expect(board_2.play).to eq(false)
		# end

		# it 'should return go to need guess if need_guess' do
		# 	expect(board_3.play).to eq("guess")
		# end
	end

	context '#print_board' do
		it 'should print the board' do
			board.create_board
			expect(board.print_board).to eq([1, [1, 2, 3, 4, 5, 6, 7, 8, 9], 5, 8, [1, 2, 3, 4, 5, 6, 7, 8, 9], 2, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 9, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 7, 6, 4, [1, 2, 3, 4, 5, 6, 7, 8, 9], 5, 2, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 4, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 8, 1, 9, [1, 2, 3, 4, 5, 6, 7, 8, 9], 1, 9, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 7, 3, [1, 2, 3, 4, 5, 6, 7, 8, 9], 6, 7, 6, 2, [1, 2, 3, 4, 5, 6, 7, 8, 9], 8, 3, [1, 2, 3, 4, 5, 6, 7, 8, 9], 9, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 6, 1, [1, 2, 3, 4, 5, 6, 7, 8, 9], 5, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 7, 6, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 3, [1, 2, 3, 4, 5, 6, 7, 8, 9], 4, 3, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 2, [1, 2, 3, 4, 5, 6, 7, 8, 9], 5, [1, 2, 3, 4, 5, 6, 7, 8, 9], 1, 6, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9], 3, [1, 2, 3, 4, 5, 6, 7, 8, 9], 8, 9, [1, 2, 3, 4, 5, 6, 7, 8, 9], [1, 2, 3, 4, 5, 6, 7, 8, 9]]
)
		end
	end

	context '#get_row' do
		it 'should get all the number in the row' do
			board.create_board
			expect(board.get_row(1)).to eq([1,5,8,2])
		end

		it 'should also get all numer from row 9' do
			board.create_board
			expect(board.get_row(9)).to eq([6,3,8,9])
		end
	end

	context '#get_col' do
		it 'should get all the number in the col' do
			board.create_board
			expect(board.get_col(1)).to eq([1,2,7,4,6])
		end

		it 'should also get all numer from col 9' do
			board.create_board
			expect(board.get_col(9)).to eq([5,9,6,1])
		end
	end

	context '#get_array_of_all' do
		it 'should give an array with all possibilites' do
			board.create_board
			expect(board.get_array_of_all(1)).to eq([1,2,3,5,6,8,9])
		end
	end

	context '#get_box' do
		it 'should get all the number in the box' do
			board.create_board
			expect(board.get_box(1)).to eq([1,5,9,2])
		end

		it 'should also get all numer from box 9' do
			board.create_board
			expect(board.get_box(5)).to eq([7,8,3,6,1])
		end
	end

	context '#unless_array' do
		it 'should give the value inless array' do
			board.create_board
			expect(board.unless_array(board.game_board[0])).to eq(1)
		end

		it 'should not give anything is not an array' do
			board.create_board
			expect(board.unless_array(board.game_board[1])).to eq(nil)
		end
	end
	context '#is_solved?' do
		it 'should check to see if the board is solved' do
			board.create_board
			expect(board.is_solved?).to eq(false)
		end
	end

	context '#update_cell' do
		it 'should update a cell' do
			board.create_board
			expect(board.update_cell(1)).to eq([4,7])
		end
	end

	context '#eleminiation' do
		it 'should go over and eleminate possibilites in each cell' do
			board.create_board
			board.eleminiation
			expect(board.print_board).to eq([1, [4, 7], 5, 8, [3, 9], 2, [6, 7], [6, 7], [3, 7], [3, 8], 9, [3, 8], 1, 7, 6, 4, 2, 5, 2, 7, [3, 6], 4, [3, 5], 5, 8, 1, 9, [5, 8], 1, 9, [2, 5], [4, 5], 7, 3, [4, 8], 6, 7, 6, 2, 5, 8, 3, 1, 9, 4, [3, 8], [4, 8], [3, 4, 8], [2, 9], 6, 1, [2, 7], 5, [2, 7, 8], [5, 8, 9], [2, 5, 8], 7, 6, [1, 4, 5, 9], [4, 9], 2, 3, 8, 4, 3, 8, [7, 9], 2, 9, 5, [6, 7], 1, 6, [2, 5], 1, 3, [4, 5], 8, 9, [4, 7], 7])
		end
	end

	context '#impossible?' do
		it 'should check if a board is impossible' do
			board_2.create_board
			board_2.eleminiation
			expect(board_2.impossible?).to eq(true)
		end
	end

	context '#need_guess' do
		it 'should check if the board is the same' do
			board.create_board
			board.eleminiation
			board.need_guess
			expect(board.need_guess).to eq(true)
		end

		it 'should check if the board is the same' do
			board.create_board
			board.eleminiation
			expect(board.need_guess).to eq(false)
		end
	end


	#not completely sure how to trest >.<
	# context '#brute_squad' do
	# 	it 'should guess and keep going' do
	# 		board_3.play
	# 		expect(board_3.brute_squad).to eq("solved")
	# 	end
	# end

	context '#cell_value' do
		it 'should return the value of a cell' do
			board.create_board
			expect(board.cell_value(board.game_board[0])).to eq(1)
		end
	end

	context '#cell_row' do
		it 'should give the cell row' do
			board.create_board
			expect(board.cell_row(board.game_board[12])).to eq(2)
		end
	end

	context '#cell_col' do
		it 'should give the cell col' do
			board.create_board
			expect(board.cell_col(board.game_board[12])).to eq(4)
		end
	end

	context '#cell_box' do
		it 'should give the cell box' do
			board.create_board
			expect(board.cell_box(board.game_board[12])).to eq(2)
		end
	end

end











describe Cell do
	let(:cell) { Cell.new({row:1,col: 2,box:1,value: 9})}
	let(:cell_2) {Cell.new({row:2,col: 3, box: 1})}
	let(:cell_3) {Cell.new({row:5, col:4, box:6, value: [2]})}

	context "#initialize" do
		it "creates a Cell object" do
			expect(cell).to be_an_instance_of(Cell)
		end

		it "requires parameters" do
			expect{Cell.new}.to raise_error(ArgumentError)
 		end
	end

	context '#row' do
		it "should return the row number" do
			expect(cell.row).to eq(1)
		end
	end

	context "#col" do
		it "should return col number" do
			expect(cell.col).to eq(2)
		end
	end

	context '#box' do
		it "should return box number" do
			expect(cell.box).to eq(1)
		end
	end

	context '#control' do
		it 'should send to delete_array_value and check_if_one' do
			expect(cell_2.control([1,2,4,5,6,7,8,9])).to eq(3)
		end
	end

	context '#value' do
		it "should be a value if provided" do
			expect(cell.value).to eq(9)
		end

		it "should be an array of (1..9) if not provided" do
			expect(cell_2.value).to eq((1..9).to_a)
		end
	end

	context '#delete_array_value' do
		it 'should delete a number in the array' do
			expect(cell_2.delete_array_value([1,2,4,5,6,7])).to eq([3,8,9])
		end

		it 'to change the value' do
			cell_2.delete_array_value([1,2,4,5,6,7])
			expect(cell_2.value).to eq([3,8,9])
		end
	end

	context '#change_value' do
		it "should change the value with an array of one" do
			cell_3.change_value
			expect(cell_3.value).to eq(2)
		end

		# it 'should not change the value if it is not an array' do
		# 	expect(cell.change_value(2)).to eq(9)
		# end
	end

	context '#check_if_one' do
		it 'should check do check value and change value' do
			expect(cell_3.check_if_one).to eq(2)
		end
	end

	context '#check_value' do
		it 'should be false if there is more than one num in the array' do
			expect(cell_2.check_value).to eq(false)
		end

		it 'should be true if there is only one number in the array' do
			expect(cell_3.check_value).to eq(true)
		end
	end

	context '#is_array?' do 
		it 'should be true if the value is an array' do
			expect(cell_2.is_array?).to eq(true)
		end

		it 'should be false if the value is not an array' do
			expect(cell.is_array?).to eq(false)
		end
	end

end


describe Controller do
	let(:controll) {Controller.new("105802000090076405200400819019007306762083090000061050007600030430020501600308900")}
	let(:false_control) {Controller.new("2klsdfl lsfjslkef 323")}
	let(:nil_control) {Controller.new("")}

	context '#initialize' do
		it 'should create and instance of controller' do
			expect(controll).to be_an_instance_of(Controller)
		end

		it 'should take a parameter' do
			expect{Controller.new}.to raise_error(ArgumentError)
		end
	end

	context '#input' do
		it 'should be a string' do
			expect(controll.input.is_a?(String)).to eq(true)
		end
	end

	context '#check_params' do
		it 'should check if params does not have any numbers' do
			expect(controll.check_params).to be(true)
		end

		it 'should be false if there is numbers' do
			expect(false_control.check_params).to be(false)
		end
	end

	context '#is_not_nil?' do
		it 'should check if input is nil' do
			expect(nil_control.is_not_nil?).to be(false)
		end

		it 'should be true if not nil' do
			expect(controll.is_not_nil?).to be(true)
		end
	end

	context '#check_length' do
		it 'should be false if not 81'do
			expect(false_control.check_length).to be(false)
		end

		it 'should be true if length is 81' do
			expect(controll.check_length).to be(true)
		end
	end

	context '#solve' do
		it 'should send the info over and solve the game if valid input' do
			expect(controll.solve).to eq("-------------\n|145|892|673|\n|893|176|425|\n|276|435|819|\n-------------\n|519|247|386|\n|762|583|194|\n|384|961|752|\n-------------\n|957|614|238|\n|438|729|561|\n|621|358|947|\n-------------\n")
		end

		it 'should not solve if not valid input' do
			expect(nil_control.solve).to eq("input must contain no punctuation, letters or spaces and equal 81")
		end

		it 'should also not for the other solution' do
			expect(false_control.solve).to eq("input must contain no punctuation, letters or spaces and equal 81")
		end

		it "should throw and error if input is not 81" do
			expect(false_control.solve).to eq("input must contain no punctuation, letters or spaces and equal 81")
		end
	end

	context '#check_false' do
		it 'should send to views::impossible if false' do
			expect(controll.check_false(false)).to eq("INCONCEIVABLE!!!")
		end

		it 'should print board if given an array' do
			expect(controll.check_false([1, 4, 5, 8, 9, 2, 6, 7, 3, 8, 9, 3, 1, 7, 6, 4, 2, 5, 2, 7, 6, 4, 3, 5, 8, 1, 9, 5, 1, 9, 2, 4, 7, 3, 8, 6, 7, 6, 2, 5, 8, 3, 1, 9, 4, 3, 8, 4, 9, 6, 1, 7, 5, 2, 9, 5, 7, 6, 1, 4, 2, 3, 8, 4, 3, 8, 7, 2, 9, 5, 6, 1, 6, 2, 1, 3, 5, 8, 9, 4, 7])).to eq("-------------\n|145|892|673|\n|893|176|425|\n|276|435|819|\n-------------\n|519|247|386|\n|762|583|194|\n|384|961|752|\n-------------\n|957|614|238|\n|438|729|561|\n|621|358|947|\n-------------\n")
		end
	end

	# context '#error_message' do
	# 	it 'should print text' do
	# 		expect(nil_control.).to eq("input must contain no punctuation, letters or spaces")		
	# 	end
	# end
end

describe "Views" do
	extend Views

	it 'should give an error message if input is not right' do
		expect(Views::Error.render).to eq("input must contain no punctuation, letters or spaces and equal 81")
	end

	it 'should give impossile if it is an impossile board' do
		expect(Views::Impossible.render).to eq("INCONCEIVABLE!!!")
	end

	it 'should print out the string in a sudoku form' do
		expect(Views::BoardView.render([1, 4, 5, 8, 9, 2, 6, 7, 3, 8, 9, 3, 1, 7, 6, 4, 2, 5, 2, 7, 6, 4, 3, 5, 8, 1, 9, 5, 1, 9, 2, 4, 7, 3, 8, 6, 7, 6, 2, 5, 8, 3, 1, 9, 4, 3, 8, 4, 9, 6, 1, 7, 5, 2, 9, 5, 7, 6, 1, 4, 2, 3, 8, 4, 3, 8, 7, 2, 9, 5, 6, 1, 6, 2, 1, 3, 5, 8, 9, 4, 7])).to eq("-------------\n|145|892|673|\n|893|176|425|\n|276|435|819|\n-------------\n|519|247|386|\n|762|583|194|\n|384|961|752|\n-------------\n|957|614|238|\n|438|729|561|\n|621|358|947|\n-------------\n")
	end

	it 'should split the array so it has many smaller arrays for parts, lines, and triples' do
		expect(Views::BoardView.split_array([1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3,1,2,3])).to eq([[[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]],[[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]],[[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]]])
	end

	it 'should have a string of 3 be printed as such' do
		expect(Views::BoardView.trip_string([1,2,3])).to eq("123")
	end

	it 'should give the 3 triple and a |' do
		expect(Views::BoardView.row_string([[1,2,3,],[1,2,3],[1,2,3]])).to eq('123|123|123|')
	end

	it 'should give a part' do
		expect(Views::BoardView.part_string([[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]] )).to eq("|123|123|123|\n|123|123|123|\n|123|123|123|\n")
	end

	it 'should go through and present the board as a string' do
		expect(Views::BoardView.board_to_string([[[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]],[[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]],[[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]],[[1,2,3],[1,2,3],[1,2,3]]]])).to eq("|123|123|123|\n|123|123|123|\n|123|123|123|\n-------------\n|123|123|123|\n|123|123|123|\n|123|123|123|\n-------------\n|123|123|123|\n|123|123|123|\n|123|123|123|\n-------------\n")
	end

end