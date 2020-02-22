defmodule HighRollerTest do
  use ExUnit.Case
  import Mox

  describe "When rolling dice with options" do
    test "it should keep the highest dice when asked" do
      HighRoller.RandomMock
      |> stub(:roll, fn 5, 6 ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, kh: 2) == [6, 5]
    end

    test "it should keep the lowest dice" do
      HighRoller.RandomMock
      |> stub(:roll, fn 5, 6 ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, kl: 2) == [2, 3]
    end

    test "it should drop the lowest dice" do
      HighRoller.RandomMock
      |> stub(:roll, fn 5, 6 ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, dl: 2) == [4, 5, 6]
    end

    test "it should drop the highest dice" do
      HighRoller.RandomMock
      |> stub(:roll, fn 5, 6 ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, dh: 2) == [2, 3, 4]
    end

    test "it should return the results when given an invalid option" do
      HighRoller.RandomMock
      |> stub(:roll, fn 5, 6 ->
           [2, 5, 3, 4, 6]
         end)

      assert HighRoller.roll_with_options(5, 6, invalid_option: 2) == [2, 5, 3, 4, 6]
    end
  end
end
