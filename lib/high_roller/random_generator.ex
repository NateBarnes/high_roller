defmodule HighRoller.RandomGenerator do
  @callback roll(num_of_dice :: integer(), sides :: integer()) :: list(integer)
  @callback roll(num_of_dice :: integer(), sides :: integer(), current_result :: list(integer)) :: list(integer)
end
