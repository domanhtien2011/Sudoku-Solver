# For this problem, I use a simple backtracking algorithm because I think it is simple and in the time constraint of the problem.
class Sudoku
  attr_reader :board
  def initialize
    @@number_of_solutions = 0
    @board = Array.new(9){Array.new(9)}

    @board[0][0] = 0
    @board[0][1] = 3
    @board[0][2] = 0
    @board[0][3] = 0
    @board[0][4] = 6
    @board[0][5] = 8
    @board[0][6] = 0
    @board[0][7] = 0
    @board[0][8] = 0

    @board[1][0] = 0
    @board[1][1] = 4
    @board[1][2] = 0
    @board[1][3] = 0
    @board[1][4] = 0
    @board[1][5] = 0
    @board[1][6] = 0
    @board[1][7] = 0
    @board[1][8] = 1

    @board[2][0] = 1
    @board[2][1] = 0
    @board[2][2] = 0
    @board[2][3] = 3
    @board[2][4] = 0
    @board[2][5] = 0
    @board[2][6] = 0
    @board[2][7] = 7
    @board[2][8] = 0

    @board[3][0] = 7
    @board[3][1] = 2
    @board[3][2] = 0
    @board[3][3] = 0
    @board[3][4] = 5
    @board[3][5] = 0
    @board[3][6] = 8
    @board[3][7] = 0
    @board[3][8] = 0

    @board[4][0] = 0
    @board[4][1] = 0
    @board[4][2] = 4
    @board[4][3] = 0
    @board[4][4] = 0
    @board[4][5] = 0
    @board[4][6] = 6
    @board[4][7] = 0
    @board[4][8] = 0

    @board[5][0] = 8
    @board[5][1] = 0
    @board[5][2] = 0
    @board[5][3] = 0
    @board[5][4] = 0
    @board[5][5] = 9
    @board[5][6] = 2
    @board[5][7] = 0
    @board[5][8] = 0

    @board[6][0] = 0
    @board[6][1] = 0
    @board[6][2] = 0
    @board[6][3] = 0
    @board[6][4] = 2
    @board[6][5] = 0
    @board[6][6] = 0
    @board[6][7] = 0
    @board[6][8] = 0

    @board[7][0] = 5
    @board[7][1] = 0
    @board[7][2] = 1
    @board[7][3] = 0
    @board[7][4] = 0
    @board[7][5] = 0
    @board[7][6] = 0
    @board[7][7] = 0
    @board[7][8] = 0

    @board[8][0] = 0
    @board[8][1] = 0
    @board[8][2] = 0
    @board[8][3] = 0
    @board[8][4] = 0
    @board[8][5] = 5
    @board[8][6] = 0
    @board[8][7] = 9
    @board[8][8] = 0
  end

  class << self

    def is_full(board)
      board.each_with_index do |row, row_index|
        row.each_with_index do |columns, column_index|
          if board[row_index][column_index] == 0
            return false
          end
        end
      end
      return true
    end

    def initialize_box_index(board_index)
      case board_index
        when 0..2
          row_index = 0
        when 3..5
          row_index = 3
        else
          row_index = 6
      end
    end

    def initialize_possible_numbers
      possible_numbers = []
      (1..9).each do |number|
        possible_numbers[number] = 0
      end
      possible_numbers
    end

    def check_row_constraint(board, board_row_index, possible_numbers)
      (0...9).each do |number|
        unless board[board_row_index][number] == 0
          possible_numbers[board[board_row_index][number]] = 1 # 1 means that the number already appears in the row
        end
      end
      possible_numbers
    end

    def check_column_constraint(board, board_column_index, possible_numbers)
      (0...9).each do |number|
        unless board[number][board_column_index] == 0
          possible_numbers[board[number][board_column_index]] = 1 # 1 means that the number already appears in the column
        end
      end
      possible_numbers
    end

    def check_box_constraint(board, board_column_index, board_row_index, possible_numbers)
      row_index = initialize_box_index(board_row_index)
      column_index = initialize_box_index(board_column_index)
      (row_index...row_index + 3).each do |x|
        (column_index...column_index + 3).each do |y|
          unless board[x][y] == 0
            possible_numbers[board[x][y]] = 1 # 1 means that the number already appears at a particular row or column in the box
          end
        end
      end
      possible_numbers
    end

    def generate_possible_numbers(possible_numbers)
      (1..9).each do |number|
        if possible_numbers[number] == 0
          possible_numbers[number] = number
        else
          possible_numbers[number] = 0
        end
      end
      possible_numbers
    end

    def get_possible_numbers(board, board_row_index, board_column_index)
      possible_numbers = initialize_possible_numbers

      # Check if a number already appears at a particular row
      check_row_constraint(board, board_row_index, possible_numbers)

      # Check if a number already appears at a particular column
      check_column_constraint(board, board_column_index, possible_numbers)

      # check if a number already appears in a 3 x 3 box
      check_box_constraint(board, board_column_index, board_row_index, possible_numbers)

      generate_possible_numbers(possible_numbers)
    end

    def get_empty_cell_indexes(board)
      (0..8).each do |row_index|
        (0..8).each do |column_index|
          if board[row_index][column_index] == 0
            row_index = row_index
            column_index = column_index
            return row_index, column_index
          else
            next
          end
        end
      end
    end

    def print_board(board)
      board.each_with_index do |row, row_index|
        row.each_with_index do |column, column_index|
          print board[row_index][column_index].to_s + ' '
        end
        puts
      end
    end

    def solve_sudoku(board)
      begin
        possible_numbers = []
        if is_full(board)
          if @@number_of_solutions > 1
            abort 'This sudoku has more than one unique solution'
          end
          @@number_of_solutions += 1
          puts("The solution for this Sudoku puzzle is: ")
          print_board(board)
          return
        else
          row_index, column_index = get_empty_cell_indexes(board)
          possible_numbers = get_possible_numbers(board, row_index, column_index)
          # Start testing all possible numbers
          (1..9).each do |number|
            unless possible_numbers[number] == 0
              board[row_index][column_index] = number
              solve_sudoku(board)
            end
          end
          board[row_index][column_index] = 0
        end
      rescue
        puts 'This puzzle is impossible to solve or sth else goes wrong!'
      end
    end
  end
end

new_board = Sudoku.new
Sudoku.solve_sudoku(new_board.board)



