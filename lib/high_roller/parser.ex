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
    |> parse_operators
    |> roll_dice_chunks()
    |> resolve_integers()
    |> combine()
    |> Enum.sum()
  end

  defp roll_dice_chunks([]), do: []
  defp roll_dice_chunks([roll_string | remaining]) do
    if String.match?(roll_string, ~r/[0-9]+d[0-9]+/) do
      [parse_single_roll(roll_string) | roll_dice_chunks(remaining)]
    else
      [roll_string | roll_dice_chunks(remaining)]
    end
  end

  defp parse_single_roll(roll_string) do
    [num_of_dice, back_half] = String.split(roll_string, "d", parts: 2)
    [sides, options] = parse_options(back_half)

    {num_of_dice, _} = Integer.parse(num_of_dice)
    {sides, _} = Integer.parse(sides)

    Enum.sum(HighRoller.roll_with_options(num_of_dice, sides, options))
  end

  defp parse_options(back_half) do
    if(String.match?(back_half, ~r/kh|kl|k|dh|dl|d/)) do
      [sides, option_name, option_number] = String.split(back_half, ~r/kh|kl|k|dh|dl|d/, include_captures: true)
      {actual_number, _} = Integer.parse(option_number)
      [sides, [{String.to_atom(option_name), actual_number}]]
    else
      [back_half, {}]
    end
  end

  defp parse_operators(roll_string) do
    Regex.split(~r/\+|\-/, roll_string, include_captures: true)
  end

  defp resolve_integers([]), do: []
  defp resolve_integers([chunk | remaining]) when is_bitstring(chunk) do
    case Integer.parse(chunk) do
      {result, ""} -> [result | resolve_integers(remaining)]
      {_, _} -> [chunk | resolve_integers(remaining)]
      :error -> [chunk | resolve_integers(remaining)]
    end
  end
  defp resolve_integers([chunk | remaining]), do: [chunk | resolve_integers(remaining)]

  defp combine([first_number, "+", second_number | remaining]), do: combine([first_number + second_number | remaining])
  defp combine([first_number, "-", second_number | remaining]), do: combine([first_number - second_number | remaining])
  defp combine(chunks), do: chunks
end
