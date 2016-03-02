require 'matrix'

class Organism

  attr_accessor :cells, :next_state

  def initialize(init_state)
    @cells = []
    @next_state = []

    init_state.each do |e|
      @cells << e.dup
      @next_state << e.dup
    end
  end

  def evolve
    @cells = []
    @next_state.each do |e|
      @cells << e.dup
    end
  end

  def find_neighbors(x, y)
    coordinates_for_neighbors = coordinates(x, y)

    matrix = Matrix.rows @cells

    neighbors = []
    coordinates_for_neighbors.each do |(x, y)|
      if(x.between?(0, matrix.row_count - 1) and
         y.between?(0, matrix.column_count - 1)) then
        neighbors << @cells[x][y]
      end
    end
    neighbors
  end

  def coordinates(x, y)
    [[x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
     [x, y - 1],                 [x, y + 1],
     [x + 1, y - 1], [x + 1, y], [x + 1, y + 1]]
  end

  def might_die_because_has_fewer_than_two_neighbours(cell, neighbors)
    neighbors.count(1) < 2
  end

  def might_live_because_has_two_or_three_neighbours(cell, neighbors)
    (neighbors.count(1) >= 2 and neighbors.count(1) <= 3)
  end

  def might_die_because_has_more_than_tree_neighbours(cell,neighbors)
    neighbors.count(1) > 3
  end

  def might_reborn_because_has_exactly_three_neighbours(cell, neighbors)
    (neighbors.count(1)==3)
  end

  def next_state
    matrix = Matrix.rows @cells

    matrix.each_with_index do |cell, x, y|
      neighbors = find_neighbors(x, y)
      case cell
        when 1
          @next_state[x][y] = 0 if(might_die_because_has_fewer_than_two_neighbours(cell, neighbors) or might_die_because_has_more_than_tree_neighbours(cell, neighbors))
          @next_state[x][y] = 1 if(might_live_because_has_two_or_three_neighbours(cell, neighbors))
        else
          @next_state[x][y] = might_reborn_because_has_exactly_three_neighbours(cell, neighbors) ? 1 : 0
      end
    end
    @next_state
  end

end
