defmodule HighRoller.Parser do
  @moduledoc """
  Documentation for the Parser module. This module contains all the code for parsing strings and turning them into the results of dice rolls.
  """

  @doc """
  Parses a roll string into a final result

  ## Examples

      iex> HighRoller.Parser.parse("3d1")
      3

  """
  def parse(roll_string) do
    case parse_with_results(roll_string) do
      %{total: total} -> total
      :error -> :error
    end
  end

  @doc """
  Parses a roll string and returns both the final result and the results of each of the rolls

  ## Examples

      iex> HighRoller.Parser.parse("3d1+1")
      {total: 4, full_results: [[1, 1, 1], "+", 1]}

  """
  def parse_with_results(roll_string) do
    try do
      roll_string
      |> parse_operators
      |> roll_dice_chunks()
      |> resolve_integers()
      |> create_result_map()
    rescue
      ArithmeticError -> :error
    end
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

    HighRoller.roll_with_options(num_of_dice, sides, options)
  end

  defp parse_options(back_half) when is_bitstring(back_half), do: parse_options(String.split(back_half, ~r/kh|kl|k|dh|dl|d/, include_captures: true))
  defp parse_options([sides_string]), do: [sides_string, {}]
  defp parse_options([sides_string, option_name, option_number]) do
    {actual_number, _} = Integer.parse(option_number)
    [sides_string, [{String.to_atom(option_name), actual_number}]]
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

  defp resolve_roll_groups([]), do: []
  defp resolve_roll_groups([chunk | remaining]) when is_list(chunk) do
    [Enum.sum(chunk) | resolve_roll_groups(remaining)]
  end
  defp resolve_roll_groups([chunk | remaining]), do: [chunk | resolve_roll_groups(remaining)]

  defp create_result_map(chunks) do
    total = chunks
    |> resolve_roll_groups()
    |> combine()
    |> Enum.sum()

    %{total: total, full_results: chunks}
  end

  defp combine([first_number, "+", second_number | remaining]), do: combine([first_number + second_number | remaining])
  defp combine([first_number, "-", second_number | remaining]), do: combine([first_number - second_number | remaining])
  defp combine(chunks), do: chunks
end
