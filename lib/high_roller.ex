defmodule HighRoller do
  @moduledoc """
  Documentation for HighRoller.
  """

  @doc """
  Rolls dice via a method.

  ## Examples

      iex> HighRoller.roll(1, 1)
      [1]

  """
  def roll(num_of_dice, sides, current_result \\ [])
  def roll(num_of_dice, _sides, current_result) when num_of_dice == 0, do: current_result
  def roll(num_of_dice, sides, current_result) do
    roll(num_of_dice - 1, sides, [Enum.random(1..sides) | current_result])
  end
end
