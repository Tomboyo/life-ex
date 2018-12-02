@moduledoc """
A cartesian coordinate pair
"""
defmodule Point do
  @enforce_keys [:x, :y]
  defstruct [:x, :y]

  @doc """
  Get the point translated by delta from the origin.
  """
  def translate(origin, delta) do
    %Point{
      x: origin.x + delta.x,
      y: origin.y + delta.y
    }
  end
end