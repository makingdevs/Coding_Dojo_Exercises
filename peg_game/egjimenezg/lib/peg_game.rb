class PegGame
  attr_accessor :board

  def initialize(rows,cols)
    @board = []
    rows.times do | row |
      @board << []    

      colsForRow = cols-1
      displacement = 0
      
      if(row % 2 != 0) then
        @board[row][0] = " "
        @board[row][(cols*2)-2] = " "
        colsForRow -= 1
        displacement = 1
      end

      colsForRow.times do | col |
        @board[row][(col*2)+displacement] = "X"
        @board[row][(col*2)+1+displacement] = "."
      end

      @board[row][(colsForRow*2)+displacement] = "X"

    end
  end

 # def quitSpikeIn(row,col)
 #   @board[row][col] = "."
 # end

end
