defmodule HighRollerTest do
  use ExUnit.Case
  doctest HighRoller

  describe "when rolling dice via method call" do
    test "rolls a d6 properly" do
      result = HighRoller.roll(100_000, 6)
               |> Enum.sum
               |> Kernel./(100_000)
               |> Float.round(1)

      assert result == 3.5
    end

    test "rolls a d20 properly" do
      result = HighRoller.roll(100_000, 20)
               |> Enum.sum
               |> Kernel./(100_000)
               |> Float.round(1)

      assert result == 10.5
    end
  end
end
