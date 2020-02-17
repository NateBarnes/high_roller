defmodule HighRollerTest do
  use ExUnit.Case
  doctest HighRoller

  describe "When rolling dice with options" do
    test "it should keep the highest dice when asked" do
      assert HighRoller.roll_with_options(5, 6, kh: 2) == [6, 5]
    end
  end
end
