require_relative '../sudoku_solver'

describe Sudoku do
  before(:each) do
    @board = Sudoku.new.board
    @possible_numbers = [nil, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  describe ".create_new_board" do
    it 'should return a new board' do
      expect(@board).to be_instance_of(Array)
    end
  end

  describe '.get_empty_cell_indexes' do
    it 'should return the indexes of the empty cell' do
      expect(Sudoku.get_empty_cell_indexes(@board)).to eql([0, 0])
    end
  end

  describe '.check_row_constraint' do
    it "should return the possible numbers for a particular row" do
      # The possible numbers are: 1, 2, 4, 5, 7, 9. These numbers are different for different boards, of course.
      expect(Sudoku.check_row_constraint(@board, 0, @possible_numbers)).to eql([nil, 0, 0, 1, 0, 0, 1, 0, 1, 0])
    end
  end

  describe '.check_column_constraint' do
    it "should return the possible numbers for a column row" do
      # The possible numbers are: 2, 3, 4, 6, 9. These numbers are different for different boards, of course.
      expect(Sudoku.check_column_constraint(@board, 0, @possible_numbers)).to eql([nil, 1, 0, 0, 0, 1, 0, 1, 1, 0])
    end
  end

  describe '.check_box_constraint' do
    it "should return the possible numbers that haven't appeared in the box" do
      # The possible numbers are for the first empty cell: 2, 5, 6, 7, 8, 9. These numbers are different for different boards, of course.
      expect(Sudoku.check_box_constraint(@board, 0, 0, @possible_numbers)).to eql([nil, 1, 0, 1, 1, 0, 0, 0, 0, 0])
    end
  end
end
