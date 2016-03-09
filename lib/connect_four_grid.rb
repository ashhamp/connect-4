class ConnectFourGrid
  attr_reader :rows, :columns, :pointer_row
  attr_accessor :grid

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    @grid = create_grid
    @pointer_row = create_pointer_row
  end

  def create_grid
    grid = []
    @rows.times do |row_index|
      grid[row_index] = []
      @columns.times do |col_index|
        grid[row_index][col_index] = " "
      end
    end
    grid
  end

  def create_pointer_row
    (1..@columns).to_a
  end

  def column(col_num)
    column = []
    @grid.each do |row|
      row.each_with_index do |square, index|
        if index == col_num - 1
          column << square
        end
      end
    end
    column
  end

  def row(row_num)
    reversed[row_num]
  end

  def reversed
    @grid.reverse
  end

  def print_grid
    @grid.each do |row|
      row.each_with_index do |square, index|
        if index == 0
          print "| #{square} "
        elsif index == @columns - 1
          print "#{square} |\n"
        else
          print "#{square} "
        end
      end
    end
    @pointer_row.each_with_index do |square, index|
      if index == 0
        print "| #{square} "
      elsif index == @columns - 1
        print "#{square} |\n"
      else
        print "#{square} "
      end
    end
  end
end
