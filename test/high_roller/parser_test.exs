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
  end
end
