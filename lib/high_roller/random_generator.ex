defmodule HighRoller.RandomGenerator do
  @moduledoc """
  Documentation for the HighRoller.Random behavior. This defines a behavior for modules that generate randomness.
  """
  @callback roll(num_of_dice :: integer(), sides :: integer()) :: list(integer)
  @callback roll(num_of_dice :: integer(), sides :: integer(), current_result :: list(integer)) :: list(integer)
end
