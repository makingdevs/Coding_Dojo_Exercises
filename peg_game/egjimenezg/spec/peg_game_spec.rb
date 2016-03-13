require 'peg_game'

RSpec.describe PegGame do

  game = PegGame.new(5,5)

  it "should create a new board of RxC" do
    expect(game.board.size).to eq(5) 
  end 

  [
    [1, 1, 4],
    [2, 1, 5],
    [3, 2, 4]
  ].each do |row, col, size|
    it "should quit spike in (#{row}, #{col}) from board" do
      game_row = game.board[row]
      p game_row
      spikes = game_row.count('X')
      expect(spikes).to eq size
      game.quitSpikeIn(row, col)

      game_row = game.board[row]
      spikes = game_row.count('X')
      expect(spikes).to eq(size - 1)
    end
  end
  
  it "should calculate the probability from the column of the first row until the target column in the last row" do
    missingPegs = [[1,1],[2,1],[3,2]]
    missingPegs.each do |x, y|
      game.quitSpikeIn(x,y) 
    end 
   
    expect(game.getProbabilityFromColumnToTargetColumn(0,0)).to eq(0.5)
  end

end 
