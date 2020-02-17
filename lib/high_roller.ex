defmodule HighRoller do
  @moduledoc """
  Documentation for main HighRoller module
  """

  def roll_with_options(num_of_dice, sides, options) do
    roll(num_of_dice, sides)
    |> keep(options)
  end

  defp keep(results, kh: number_to_keep) do
    Enum.sort(results, &(&1 >= &2))
    |> Enum.take(number_to_keep)
  end
end
