require 'peg_game'

RSpec.describe PegGame do

  game = PegGame.new(5,5)

  it "should create a new board of RxC" do
    expect(game.board.size).to eq(5) 
    expect(game.board[0]).to match_array(['X','.','X','.','X','.','X','.','X'])
    expect(game.board[1]).to match_array([' ','X','.','X','.','X','.','X',' '])
  end 

  [
    [1, 1, 4],
    [2, 1, 5],
    [3, 2, 4]
  ].each do |row, col, size|
    it "should quit spike in (#{row}, #{col}) from board" do
      game_row = game.board[row]
      spikes = game_row.count('X')
      expect(spikes).to eq size
      game.quitSpikeIn(row, col)

      game_row = game.board[row]
      spikes = game_row.count('X')
      expect(spikes).to eq(size - 1)
    end
  end

  [
    [0,[0],0,[{:column => 1,:parent => 0,:probability => BigDecimal.new("1.0")}]],
    [0,[6],0,[{:column => 5,:parent => 6,:probability => BigDecimal.new("1.0")}]],
    [0,[4],0,[{:column => 3,:parent => 4,:probability => BigDecimal.new("0.5")}]]
  ].each do | row, columns, targetColumn, columnsWithProbability |
    it "should calculate the probabilities of the ways when the ball drop from columns #{columns}" do
      probabilities = game.getProbabilityForPositions(row,columns,targetColumn)
      expect(probabilities).to match_array(columnsWithProbability)
    end 
  end
 
  it "should calculate the probability of fall from the first column to the target column" do
    probability = game.getProbabilityFromColumnToTargetColumn(0,0)
    expect(probability).to eq(0.5)
  end
end 
