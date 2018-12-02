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
      [
        grid: %{
          %Point{x: 0, y: 0} => :a,
          %Point{x: 1, y: 0} => :b,
          %Point{x: 2, y: 0} => :c,

          %Point{x: 0, y: 1} => :d,
          %Point{x: 1, y: 1} => :e,
          %Point{x: 2, y: 1} => :f,

          %Point{x: 0, y: 2} => :g,
          %Point{x: 1, y: 2} => :h,
          %Point{x: 2, y: 2} => :i,
        }
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
end
