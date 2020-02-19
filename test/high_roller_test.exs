defmodule HighRollerTest do
  use ExUnit.Case
  import Mox

  describe "When rolling dice with options" do
    test "it should keep the highest dice when asked" do
      HighRoller.RandomMock
      |> stub(:roll, fn _, _ ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, kh: 2) == [6, 5]
    end

    test "it should keep the lowest dice when asked" do
      HighRoller.RandomMock
      |> stub(:roll, fn _, _ ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, kl: 2) == [2, 3]
    end
  end
end
