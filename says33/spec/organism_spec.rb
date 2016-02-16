require "organism"

RSpec.describe Organism do 
  organism = Organism.new


  ##it "should evolve an organism with first rule" do
  ##  organism.populate([[0,0,0],[0,1,0],[1,0,1]])
  ##  organism.evolve
  ##  expect(organism.cells).to eq([[0, 0, 0],[0, 1, 0],[0, 0, 0]])
  ##end

  it "given the coordinate with [1, 1], should get around set coordinates" do
    coordinates = organism.coordinates(1, 1)
    expect(coordinates).to match_array([[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]])
  end

  it "given a cell in position [1,1] should return 8 neighbors" do
    neighbors = organism.find_neighbors(1, 1)
    expect(neighbors).to match_array([0,0,0,0,0,1,0,1])
  end

  it "given a cell in position [0,1] should return 5 neighbors" do
    neighbors = organism.find_neighbors(0, 1)
    expect(neighbors).to match_array([0,0,0,0,1])
  end

  it "given a cell in position [0,2] should return 3 neighbors" do
    neighbors = organism.find_neighbors(0, 2)
    expect(neighbors).to match_array([0,0,1])
  end

  it "given a cell in position [1,0] should return 5 neighbors" do
    neighbors = organism.find_neighbors(1, 0)
    expect(neighbors).to match_array([0,0,0,1,1])
  end

  it "given a cell in position [2, 2] should return 3 neighbors" do
    neighbors = organism.find_neighbors(2, 2)
    expect(neighbors).to match_array([0,0,1])
  end

  # Any live cell with fewer than two live neighbours dies, as if caused by under-population
  it "given a neighborhood for a livin cell with fewer than two live neighbors, should die in the next generation" do
    neighborhood = [0,0,0,0,1]
    living_cell = 1

    expect(organism.might_die_because_has_fewer_than_two_neighbours(living_cell, neighborhood)).to be_truthy
  end

  it "given a neighborhood for a livin cell with no more than 2 or 3 live neighbors should live in the next generation" do
    neighborhood = [1,1,0,0,0]
    living_cell = 1

    expect(organism.might_live_because_has_two_or_three_neighbours(living_cell, neighborhood)).to be_truthy

    neighborhood = [1,1,1,0,0]
    expect(organism.might_live_because_has_two_or_three_neighbours(living_cell, neighborhood)).to be_truthy


    neighborhood = [1,1,1,1,0]
    expect(organism.might_live_because_has_two_or_three_neighbours(living_cell, neighborhood)).to be_falsy
  end

  # Any live cell with more than three live neighbours dies, as if by over-population.
  it "given a neighborhood for a live cel with more than 3 live neighbors, should die in the next generation" do
    neighborhood = [1,1,1,1,0,0]
    living_cell = 1

    expect(organism.might_die_because_has_more_than_tree_neighbours(living_cell, neighborhood)).to be_truthy

  end
  #Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  it "given a neighborhood and a dead cell with three neighbors lives, should live in the next generation" do
    neighborhood = [1,1,1,0,0]
    died_cell=0
    expect(organism.might_reborn_because_has_exactly_three_neighbours(died_cell,neighborhood)).to be_truthy
  end

  it "given an organism [[0,0,0],[0,1,0],[1,0,1]], after the rules applied the next state should be [[0,0,0],[0,1,0],[0,1,0]]" do
    cells = organism.next_state()

    expect(cells).to match_array([[0,0,0],[0,1,0],[0,1,0]])
  end

end
