defmodule Life do
  @moduledoc """
  Defines functions to play Conway's Game of Life.
  """

  @doc """
  Create a new grid based on the given grid and the normal rules for Conway's
  Game of Life.
  """
  def advance_grid(grid) do
    for { point, cell } <- grid,
        into: %{},
        do: { 
          point,
          advance_cell(cell, count_alive(neighbors(grid, point)))
        }
  end

  @doc """
  Counts the number of cells in the given array which are :alive
  """
  def count_alive(cells) do
    Enum.reduce(cells, 0, fn cell, acc ->
        case cell do
          :alive -> acc + 1
          :dead  -> acc
        end
      end)
  end

  @doc """
  Returns a list of cells which neighbor the given point in one of eight
  cardinal directions. At the edges of the map, where there are no neighbors,
  the resulting may contain fewer than 8 cells.
  """
  def neighbors(grid, point) do
    [ {-1, -1}, {0, -1}, {1, -1},
      {-1,  0},          {1,  0},
      {-1,  1}, {0,  1}, {1,  1}
    ] |> Enum.map(fn {x, y} -> %Point{x: x, y: y} end) # for readability
      |> Enum.map(fn delta -> Point.translate(point, delta) end)
      |> Enum.map(fn neighbor_point -> grid[neighbor_point] end)
      |> Enum.filter(fn cell -> cell != nil end)
  end

  @doc """
  Given a cell and the number of its living neighbors, return the next state of
  the cell (:alive or :dead)
  """
  def advance_cell(:alive, 2), do: :alive
  def advance_cell(:alive, 3), do: :alive
  def advance_cell(:alive, _), do: :dead
  def advance_cell(:dead, 3), do: :alive
  def advance_cell(:dead, _), do: :dead
end
