defmodule GameOfLife do
  alias Organism

  def run(_cells, 0), do: :done
  def run(cells, steps) do
    cells
    |> print
    |> Organism.evolve
    |> run(steps - 1)
  end

  defp print(organism) do
    IO.puts(String.duplicate("\n", 100))

    for x <- (0..Organism.size(organism) - 1) do
      for y <- (0..Organism.size(organism) - 1) do
        case Organism.cell_status(organism, x, y) do
          0 -> IO.write "."
          1 -> IO.write "*"
        end
      end
      IO.puts ""
    end
     :timer.sleep(2000)
    organism
  end
end
