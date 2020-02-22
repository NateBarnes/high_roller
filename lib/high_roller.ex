defmodule HighRoller do
  @moduledoc """
  Documentation for main HighRoller module
  """

  @random_generator Application.get_env(:high_roller, :random_generator)

  @doc """
  Rolls dice via a method while allowing options.

  ## Examples

      iex> HighRoller.roll_with_options(3, 1, kh: 1)
      [1]

  """
  def roll_with_options(num_of_dice, sides, options \\ {})
  def roll_with_options(num_of_dice, sides, options) do
    num_of_dice
    |> @random_generator.roll(sides)
    |> subset(options)
  end

  defp subset(results, k: number_to_keep),  do: results |> Enum.sort(&(&1 >= &2)) |> Enum.take(number_to_keep)
  defp subset(results, kh: number_to_keep), do: results |> Enum.sort(&(&1 >= &2)) |> Enum.take(number_to_keep)
  defp subset(results, kl: number_to_keep), do: results |> Enum.sort() |> Enum.take(number_to_keep)
  defp subset(results, d: number_to_drop),  do: results |> Enum.sort() |> Enum.drop(number_to_drop)
  defp subset(results, dl: number_to_drop), do: results |> Enum.sort() |> Enum.drop(number_to_drop)
  defp subset(results, dh: number_to_drop), do: results |> Enum.sort() |> Enum.drop(number_to_drop * -1)
  defp subset(results, _), do: results
end
