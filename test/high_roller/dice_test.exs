defmodule HighRoller.DiceTest do
  use ExUnit.Case

  describe "when rolling dice via method call" do
    test "rolls a d6 properly" do
      result = 100_000
               |> HighRoller.Dice.roll(6)
               |> Enum.sum
               |> Kernel./(100_000)
               |> Float.round(1)

      assert result == 3.5
    end

    test "rolls a d8 properly" do
      result = 100_000
               |> HighRoller.Dice.roll(8)
               |> Enum.sum
               |> Kernel./(100_000)
               |> Float.round(1)

      assert result == 4.5
    end
  end
end
