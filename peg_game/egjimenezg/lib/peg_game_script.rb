require './peg_game'

inputFile = File.open("input_peg.txt","r")
outputFile = File.open("output_peg.txt","w")

cases = inputFile.gets.tr("\n","").to_i

cases.times do | i |
  line = inputFile.gets.split
  rows = line[0].to_i
  cols = line[1].to_i
  targetColumn = line[2].to_i
  spikesRemoved = line[3].to_i

  points = []

  spikesRemoved.times do | j |
    point = [line[4+(j*2)],line[4+((j*2)+1)]] 
    points << point
  end 

  game = PegGame.new(rows,cols)

  points.each do | x, y |
    game.quitSpikeIn(x.to_i,y.to_i)
  end
  
  result = game.getColumnWithHighestProbabilityToFallInTargetColumn(targetColumn)
  outputFile.write("#{result[:column]} #{result[:probability]}\n")
end
