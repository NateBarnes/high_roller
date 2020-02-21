defmodule HighRoller.Parser do
  @moduledoc """
  Documentation for the Parser module. This module contains all the code for parsing strings and turning them into the results of dice rolls.
  """

  def parse(roll_string) do
    roll_string
    |> List.wrap()
    |> roll_dice_chunks()
    |> Enum.sum()
  end

  defp roll_dice_chunks([roll_string | _remaining]) do
    [num_of_dice, sides] = String.split(roll_string, "d")

    {num_of_dice, _} = Integer.parse(num_of_dice)
    {sides, _} = Integer.parse(sides)

    HighRoller.roll_with_options(num_of_dice, sides)
  end
end
