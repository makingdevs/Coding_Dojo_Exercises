defmodule OrganismTest do
  use ExUnit.Case
  doctest Organism

  setup context do
    cells = [[0, 0, 0], [0, 1, 0], [1, 0, 1]]
    organism = Organism.new(cells)
    {:ok, [organism: organism, position: context[:position]]}
  end

  @tag position: []
  test "given an organism with an initial state of [[0, 0, 0], [0, 1, 0], [1, 0, 1]] it should return a new Organism structure" do
    cells = [[0, 0, 0], [0, 1, 0], [1, 0, 1]]
    organism = Organism.new(cells)
    assert ^cells = organism.cells, "There was something wrong with initialization"
  end

  @tag position: [x: 0, y: 0]
  test "given a cell in position [0, 0], it should return zero alive neighbors", context do
    organism = context[:organism]
    [x: x, y: y] = context[:position]
    alive_neighbors = Organism.alive_neighbors(organism, x, y)

    assert 1 = alive_neighbors
  end

  @tag position: [x: 1, y: 0]
  test "given a cell in position [1, 0], it should return two alive neighbors", context do
    organism = context[:organism]
    [x: x, y: y] = context[:position]
    alive_neighbors = Organism.alive_neighbors(organism, x, y)

    assert 2 = alive_neighbors
  end

  @tag position: [x: 2, y: 2]
  test "given a cell in position [2, 2], it should return two alive neighbors", context do
    organism = context[:organism]
    [x: x, y: y] = context[:position]
    alive_neighbors = Organism.alive_neighbors(organism, x, y)

    assert 1 = alive_neighbors
  end

  @tag position: [x: 1, y: 1]
  test "given a cell in position [1, 1], it should return two alive neighbors", context do
    organism = context[:organism]
    [x: x, y: y] = context[:position]
    alive_neighbors = Organism.alive_neighbors(organism, x, y)

    assert 2 = alive_neighbors
  end

  # Rule 1.- Any live cell with fewer than two live neighbours dies, as if caused by under-population
  @tag position: [x: 0, y: 2]
  test "given a living cell in position [0, 2], should die because has fewer than two live neighbors", context do
    organism = context[:organism]

    [x: x, y: y] = context[:position]
    cell_should_die = Organism.next_generation(organism, x, y)

    assert 0 = cell_should_die
  end

  # Rule 2.- Any live cell with two or three live neighbours lives on to the next generation
  @tag position: [x: 1, y: 1]
  test "given a living cell in position [1, 1], should live on to the next generation", context do
    organism = context[:organism]

    [x: x, y: y] = context[:position]
    cell_should_live = Organism.next_generation(organism, x, y)

    assert 1 = cell_should_live
  end

  # Rule 3.- Any live cell with more than three live neighbours dies, as if by over-population
  @tag position: [x: 1, y: 1]
  test "given a living cell in position [1, 1], should die because has more than three neighbors", context do
    cells = [[0, 0, 0], [0, 1, 1], [1, 1, 1]]
    organism = Organism.new(cells)

    [x: x, y: y] = context[:position]
    cell_should_die = Organism.next_generation(organism, x, y)

    assert 0 = cell_should_die
  end

  # Rule 4.- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
  @tag position: [x: 2, y: 1]
  test "given a dead cell in position [2, 1], should reborn because has exactly three neighbors", context do
    organism = context[:organism]

    [x: x, y: y] = context[:position]
    reborn_cell = Organism.next_generation(organism, x, y)
    assert 1 = reborn_cell
  end

  test "given an organism with cell distribution [[0, 0, 0], [0, 1, 0], [1, 0, 1]], the next state of the organism should be [[0, 0, 0], [0, 1, 0], [0, 1, 0]]", context do
    organism = context[:organism]
    %Organism{cells: next_status} = Organism.evolve(organism)
    assert ^next_status = [[0, 0, 0], [0, 1, 0], [0, 1, 0]]
  end

end
