class PegGame
  attr_accessor :board
  attr_accessor :rowBallPosition
  attr_accessor :colBallPosition
  attr_accessor :outColumn

  def initialize(rows,cols)
    @board = []
    rows.times do | row |
      r = []
      if(row % 2 == 0) then
        cols.times do | col |
          if (col % 2 == 0) then
            r << 'X'
          else
            r << '.'
          end
        end
        @board << r
      else
        cols.times do | col |
          if (col == 0 or col == cols-1) then
            r << '_'
          elsif (col % 2 == 0) then
            r << '.'
          else
            r << 'X'
          end
        end
        @board << r
      end
    end
  end

  def quitSpikeIn(row,col)
    realCol = (row % 2 != 0) ? col-1 : col
    if @board[row][realCol] == "X" then
      @board[row][realCol] = "."
      return true
    else
      return false
    end
  end

  def row_at(row)
    @board[row]
  end

  def compute(row, col)
    puts "row #{row}, col #{col}"
    downIsSpike = @board[row+1][col] == 'X'
    puts "downValue = #{@board[row+1][col]}"
    downIsLimit = ((@board[row+1][col-1] == '_') or (@board[row+1][col+1] == '_'))
    puts "downLeft = #{@board[row+1][col-1]}"
    puts "downRight = #{@board[row+1][col+1]}"
    puts "currRow = #{@board[row]}"
    puts "downRow = #{@board[row+1]}"
    puts "isSpike #{downIsSpike}"
    puts "isLimit #{downIsLimit}"
    puts "board #{@board}"
    if (downIsSpike and !downIsLimit) then
      return 0.5
    else
      return 1
    end
  end

  def move_the_ball()
    @rowBallPosition = @rowBallPosition + 1
    if (compute(@rowBallPosition, @colBallPosition) != 1) then
      @colBallPosition = next_column()
    end
  end

  def next_column()
    if (@colBallPosition == @outColumn) then
      return @colBallPosition+1
    elsif (@colBallPosition > @outColumn) then
      return @colBallPosition-1
    elsif (@colBallPosition < @outColumn) then
      return @colBallPosition+1
    end
  end

end
