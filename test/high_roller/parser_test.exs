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

    test "it should pass through roll options" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 20 ->
           [17, 4]
         end)

      assert HighRoller.Parser.parse("2d20kh1") == 17
    end

    test "it shouldn't get confused by drop options" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 20 ->
           [17, 4]
         end)

      assert HighRoller.Parser.parse("2d20d1") == 17
    end

    test "it should add specific dice together" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse("2d8+2d8") == 24
    end

    test "it should gracefully handle spaces in the input" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse("2d8 + 2d8") == 24
    end

    test "it should also add integers to the dice rolls" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse("2d8+3") == 15
    end

    test "it should also subtract integers from the dice rolls" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse("2d8-3") == 9
    end

    test "it should also work with many combinations of dice and integers" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse("2d8+5+2d8-3") == 26
    end

    test "it should fail gracefully" do
      assert HighRoller.Parser.parse("invalid") == :error
    end
  end

  describe "when returning the full result of a parse" do
    test "it should return the results alongside the roll" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse_with_results("2d8+5") == %{total: 17, full_results: [[4, 8], "+", 5]}
    end

    test "it should gracefully fail when given an invalid input" do
      HighRoller.RandomMock
      |> stub(:roll, fn 2, 8 ->
           [4, 8]
         end)

      assert HighRoller.Parser.parse_with_results("invalid input") == :error
    end
  end
end
