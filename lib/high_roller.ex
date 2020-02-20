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
  def roll_with_options(num_of_dice, sides, options) do
    @random_generator.roll(num_of_dice, sides)
    |> subset(options)
  end

  defp subset(results, kh: number_to_keep), do: Enum.sort(results, &(&1 >= &2)) |> Enum.take(number_to_keep)
  defp subset(results, kl: number_to_keep), do: Enum.sort(results) |> Enum.take(number_to_keep)
  defp subset(results, dl: number_to_drop), do: Enum.sort(results) |> Enum.drop(number_to_drop)
  defp subset(results, _), do: results
end
