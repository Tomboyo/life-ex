@moduledoc """
Defines functions to render a Life grid in a loop to the console.

This is a quick and cheap way to watch the Life module do its thing!
"""
defmodule ConsolePlayer do
  
  @doc """
  Begins rendering life grids to the console, 1 per second. This starts the game
  with a Tumbler on the grid, which never dies off.
  """
  def start_link_tumbler do
    to_grid([
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0],
      [0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0],
      [0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0],
      [0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0],
      [0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0],
      [0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    ])
      |> Enum.map(fn {p, c} -> {p, case c do 0 -> :dead; 1 -> :alive end} end)
      |> Enum.into(%{})
      |> start_link()
  end

  def to_grid(array) do
    for { row, y } <- Enum.with_index(array),
        { cell, x } <- Enum.with_index(row),
        into: %{},
        do: { %Point{x: x, y: y}, cell }
  end

  @doc """
  Begins rendering life grids to the console, starting from the given grid.
  """
  def start_link(grid) do
    Task.start_link(fn -> loop(grid) end)
  end

  defp loop(grid) do
    IO.puts(render(grid) <> "\n")
    Process.sleep(1_000)
    loop(Life.advance_grid(grid))
  end

  defp render(:alive), do: "█"
  defp render(:dead), do: "·"
  defp render(grid) do
    grid
      |> Map.to_list()
      |> Enum.map(fn {point, cell} -> {point, render(cell)} end)
      |> Enum.sort(fn {p1, _}, {p2, _} -> p1.x < p2.x end)
      |> Enum.sort(fn {p1, _}, {p2, _} -> p1.y <= p2.y end)
      |> Enum.chunk_by(fn {point, _} -> point.y end)
      |> Enum.map_join("\n", fn row ->
        row |> Enum.map_join("", fn {_, cell} -> cell end)
      end)
  end
end
