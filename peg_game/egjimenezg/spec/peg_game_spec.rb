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
      p game_row
      spikes = game_row.count('X')
      expect(spikes).to eq size
      game.quitSpikeIn(row, col)

      game_row = game.board[row]
      spikes = game_row.count('X')
      expect(spikes).to eq(size - 1)
    end
  end
  
  it "should calculate the probabilities of the ways when the ball drop from first column" do
    probabilities = game.getProbabilityForPositions(0,[0],0)
    expect(probabilities).to match_array([[{:column => 1,:probability => 1.0}]])
  end 
  
end 
