class PegGame
  attr_accessor :board

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
    if @board[row][col] == "X" then
      @board[row][col] = "."
      return true
    else
      return false
    end
  end

  def row_at(row)
    @board[row]
  end
end
