class PegGame
  attr_accessor :board

  def initialize(rows,cols)
    @board = []

    rows.times do | row |
      if(row % 2 == 0) then
        @board << ['X','X','X','X','X']
      else
        @board << ['X','X','X','X']
      end
    end
  end

  def quitSpikeIn(row,col)
    @board[row][col] = "."
  end

  def row_at(row)
    @board[row].join('.').chars
  end
end
