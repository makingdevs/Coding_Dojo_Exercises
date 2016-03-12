class PegGame
  attr_accessor :board

  def initialize(rows,cols)
    @board = []

    rows.times do | row |
      @board << ('X'*((row % 2 == 0) ? cols : (cols-1))).split
    end
  end

end
