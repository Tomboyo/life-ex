defmodule Point do
  @enforce_keys [:x, :y]
  defstruct [:x, :y]

  def translate(origin, delta) do
    %Point{
      x: origin.x + delta.x,
      y: origin.y + delta.y
    }
  end
end