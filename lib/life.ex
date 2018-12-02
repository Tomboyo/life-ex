defmodule Life do
  def advance_grid(grid) do
    for { point, cell } <- grid,
        into: %{},
        do: advance_cell(cell, count_alive(neighbors(grid, point)))
  end

  def count_alive(cells) do
    Enum.reduce(cells, 0, fn cell, acc ->
        case cell do
          :alive -> acc + 1
          :dead  -> acc
        end
      end)
  end

  def neighbors(grid, point) do
    [ {-1, -1}, {0, -1}, {1, -1},
      {-1,  0},          {1,  0},
      {-1,  1}, {0,  1}, {1,  1}
    ] |> Enum.map(fn {x, y} -> %Point{x: x, y: y} end) # for readability
      |> Enum.map(fn delta -> Point.translate(point, delta) end)
      |> Enum.map(fn neighbor_point -> grid[neighbor_point] end)
      |> Enum.filter(fn cell -> cell != nil end)
  end

  def advance_cell(:alive, 2), do: :alive
  def advance_cell(:alive, 3), do: :alive
  def advance_cell(:alive, _), do: :dead
  
  def advance_cell(:dead, 3), do: :alive
  def advance_cell(:dead, _), do: :dead
end
