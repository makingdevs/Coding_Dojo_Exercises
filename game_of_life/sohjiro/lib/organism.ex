defmodule Organism do
  defstruct cells: nil

  def new(data) when is_list(data), do: %Organism{cells: data}

  def alive_neighbors(%Organism{} = organism, x, y) do
    for position_x <- (x - 1)..(x + 1),
        position_y <- (y - 1)..(y + 1),
        position_x in 0..(size(organism)- 1) and
        position_y in 0..(size(organism) - 1) and
        not(position_x == x and position_y == y) and
        cell_status(organism, position_x, position_y) == 1
    do
      1
    end
    |> Enum.sum
  end

  def next_generation(%Organism{} = organism, x, y) do
    case {cell_status(organism, x, y), alive_neighbors(organism, x, y)} do
      {1, 2} -> 1
      {1, 3} -> 1
      {0, 3} -> 1
      _ -> 0
    end
  end

  def evolve(%Organism{} = organism) do
    %Organism{organism | cells: calculate_next_generation(organism)}
  end

  def calculate_next_generation(%Organism{} = organism) do
    for x <- 0..(size(organism) - 1) do
      for y <- 0..(size(organism) - 1) do
        next_generation(organism, x, y)
      end
    end
  end

  def cell_status(%Organism{cells: cells}, x, y) do
    cells
    |> Enum.at(x)
    |> Enum.at(y)
  end

  def size(%Organism{cells: cells}), do: length(cells)

end
