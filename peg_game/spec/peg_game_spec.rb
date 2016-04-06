require 'peg_game'

RSpec.describe PegGame do
  game = PegGame.new(5,9)

  it "should create a new board of 5x9" do
    expect(game.board.size).to eq(5)
    expect(game.row_at(0)).to match_array(['X','.','X','.','X','.','X','.','X'])
    expect(game.row_at(1)).to match_array(['_','X','.','X','.','X','.','X','_'])
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
      if game.quitSpikeIn(row, col) then
        game_row = game.board[row]
        spikes = game_row.count('X')
        expect(spikes).to eq(size - 1)
      end
    end
  end

  [
    [0, 1, 1],
    [0, 3, 0.5],
    [1, 2, 0.5]
  ].each do |row, col, prob|

    it "should get the probability equals to #{prob} for in #{row}, #{col}" do
      currentProbability = game.compute(row, col)
      expect(currentProbability).to eq(prob)
    end

  end

  it "should put the ball in the next row and same column when probability is 1 and down position is empty" do
    game.rowBallPosition = 0
    game.colBallPosition = 1
    game.move_the_ball()
    expect(game.rowBallPosition).to eq(1)
    expect(game.colBallPosition).to eq(1)
  end

  it "should put in currentColumn - 1 when currentColumn is > outColumn" do
    game.outColumn = 2
    game.colBallPosition = 4
    expect(game.next_column()).to eq(3)
  end
end
