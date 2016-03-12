require 'peg_game'

RSpec.describe PegGame do

  game = PegGame.new(5,5)

  it "should create a new board of RxC" do
    expect(game.board.size).to eq(5)    
  end 

end 
