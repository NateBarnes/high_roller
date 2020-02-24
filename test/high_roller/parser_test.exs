defmodule HighRoller.ParserTest do
  use ExUnit.Case
  import Mox

  describe "when parsing dice rolls" do
    test "it should roll specific dice" do
      HighRoller.RandomMock
      |> stub(:roll, fn 3, 20 ->
           [17, 4, 11]
         end)

      assert HighRoller.Parser.parse("3d20") == 32
    end

    test "it should add specific dice together" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 6 ->
           [2, 4]
         end)

      assert HighRoller.Parser.parse("2d8+2d6") == 18
    end
  end
end
