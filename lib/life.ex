defmodule Life do
  def advance_grid(grid) do
    for { point, cell } <- grid,
        into: %{},
        do: advance_cell(cell, count_living_neighbors(grid, point))
  end

  def count_living_neighbors(grid, point) do
    neighbors(grid, point)
      |> Enum.filter(fn cell -> cell == :alive end)
      |> length()
  end

  def neighbors(grid, point) do
    [ {-1, -1}, {0, -1}, {1, -1},
      {-1,  0},          {1,  0},
      {-1,  1}, {0,  1}, {1,  1}
    ] |> Enum.map(fn {x, y} -> %Point{x: x, y: y} end)
      |> Enum.map(fn delta -> Point.translate(point, delta) end)
      |> Enum.map(fn point -> grid[point] end)
  end

  def advance_cell(:alive, 2), do: :alive
  def advance_cell(:alive, 3), do: :alive
  def advance_cell(:alive, _), do: :dead
  
  def advance_cell(:dead, 3), do: :alive
  def advance_cell(:dead, _), do: :dead
end
