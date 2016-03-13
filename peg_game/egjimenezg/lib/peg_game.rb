class PegGame
  attr_accessor :board

  def initialize(rows,cols)
    @board << ('X'*((row % 2 == 0) ? cols : (cols-1))).split
  end

  def quitSpikeIn(row,col)
    @board[row][col] = "."
  end

  def getProbabilityFromColumnToTargetColumn(originColumn,targetColumn){

  }

end
