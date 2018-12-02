defmodule LifeTest do
  use ExUnit.Case
  doctest Life

  describe "advace_cell(:alive, n)" do
    test "a living cell with 0 neighbors dies",
      do: assert Life.advance_cell(:alive, 0) == :dead

    test "a living cell with 1 neighbors dies",
      do: assert Life.advance_cell(:alive, 1) == :dead

    test "a living cell with 2 neighbors lives",
      do: assert Life.advance_cell(:alive, 2) == :alive

    test "a living cell with 3 neighbors lives",
      do: assert Life.advance_cell(:alive, 3) == :alive

    test "a living cell with 4 neighbors dies",
      do: assert Life.advance_cell(:alive, 4) == :dead

    test "a living cell with 5 neighbors dies",
      do: assert Life.advance_cell(:alive, 5) == :dead

    test "a living cell with 6 neighbors dies",
      do: assert Life.advance_cell(:alive, 6) == :dead

    test "a living cell with 7 neighbors dies",
      do: assert Life.advance_cell(:alive, 7) == :dead

    test "a living cell with 8 neighbors dies",
      do: assert Life.advance_cell(:alive, 8) == :dead
  end

  describe "advace_cell(:dead, n)" do
    test "a dead cell with 0 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 0) == :dead

    test "a dead cell with 1 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 1) == :dead

    test "a dead cell with 2 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 2) == :dead

    test "a dead cell with 3 neighbors becomes alive",
      do: assert Life.advance_cell(:dead, 3) == :alive

    test "a dead cell with 4 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 4) == :dead

    test "a dead cell with 5 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 5) == :dead

    test "a dead cell with 6 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 6) == :dead

    test "a dead cell with 7 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 7) == :dead

    test "a dead cell with 8 neighbors stays dead",
      do: assert Life.advance_cell(:dead, 8) == :dead
  end

  describe "neighbors(grid, point)" do
    setup do
      [ grid: as_map([
          [:a, :b, :c],
          [:d, :e, :f],
          [:g, :h, :i]
        ])
      ]
    end

    test "It collects all 8 neighbors of a cell", context do
      %{ grid: grid } = context

      actual = Life.neighbors(grid, %Point{x: 1, y: 1})

      assert actual == [:a, :b, :c, :d, :f, :g, :h, :i]
    end

    test "It ignores missing neighbors at the edges of the grid", context do
      %{ grid: grid } = context

      actual = Life.neighbors(grid, %Point{x: 0, y: 0})

      assert actual == [:b, :d, :e]
    end
  end

  describe "count_alive(cells)" do
    test "It counts the number of living cells" do
      actual = Life.count_alive([:alive, :dead, :dead])
      assert actual == 1
    end
  end

  describe "advance_grid(grid)" do
    test "Produces the grid advanced by Conway's GOL rules" do
      actual = Life.advance_grid(as_map([
        [:alive, :alive, :alive],
        [:alive, :alive, :alive],
        [:alive, :alive, :alive]
      ]))

      assert actual == as_map([
        [:alive, :dead, :alive],
        [:dead,  :dead, :dead],
        [:alive, :dead, :alive]
      ])
    end
  end

  def as_map(array) do
    for { row, y } <- Enum.with_index(array),
        { cell, x } <- Enum.with_index(row),
        into: %{},
        do: { %Point{x: x, y: y}, cell }
  end
end
