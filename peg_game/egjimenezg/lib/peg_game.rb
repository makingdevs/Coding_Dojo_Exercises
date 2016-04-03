class PegGame
  attr_accessor :board,:cols

  def initialize(rows,cols)
    @board = []
    @cols = cols

    rows.times do | row |
      @board << []    

      colsForRow = cols-1
      displacement = 0
      
      if(isOdd(row)) then
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

  def quitSpikeIn(row,col)
    @board[row][isOdd(row) ? ((col*2)+1) : (col*2)] = "."
  end

  def getProbabilityForPositions(row,columns,targetColumn)
    columnProbabilities = [] 

    columns.each do | column |
      if(@board[row+1][column+1] == 'X') then
        if(column == 0) then
          columnProbabilities << {:column => column+1,:parent => column,:probability => 1.0}
        elsif(column == ((@cols-2)*2)) then
          columnProbabilities << {:column => column-1,:parent => column,:probability => 1.0} 
        else
          if(column - targetColumn >= 0) then
            columnProbabilities << {:column => column-1,:parent => column,:probability=> 0.5}
          end

          if(column+1-targetColumn+(row+1) < @board.size) then
            columnProbabilities << {:column => column+1,:parent => column,:probability=> 0.5} 
          end
        end
      end

    end

    columnProbabilities
  end

  def isOdd(row)
    row % 2 != 0
  end
end
