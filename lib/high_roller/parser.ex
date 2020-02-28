defmodule HighRoller.Parser do
  @moduledoc """
  Documentation for the Parser module. This module contains all the code for parsing strings and turning them into the results of dice rolls.
  """

  @doc """
  Parses a roll string into results.

  ## Examples

      iex> HighRoller.Parser.parse("3d1")
      3

  """
  def parse(roll_string) do
    roll_string
    |> List.wrap()
    |> parse_operators
    |> roll_dice_chunks()
    |> combine()
    |> Enum.sum()
  end

  def roll_dice_chunks([]), do: []
  def roll_dice_chunks([roll_string | remaining]) do
    if String.match?(roll_string, ~r/[0-9]+d[0-9]+/) do
      [num_of_dice, sides] = String.split(roll_string, "d")

      {num_of_dice, _} = Integer.parse(num_of_dice)
      {sides, _} = Integer.parse(sides)

      [Enum.sum(HighRoller.roll_with_options(num_of_dice, sides)) | roll_dice_chunks(remaining)]
    else
      [roll_string | roll_dice_chunks(remaining)]
    end
  end

  def parse_operators([roll_string | _remaining]) do
    Regex.split(~r/\+/, roll_string, include_captures: true)
  end

  def combine([first_number, "+", second_number | remaining]), do: combine([first_number + second_number | remaining])
  def combine(chunks), do: chunks
end
