defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle

  test "tests all green" do
    result = Games.Wordle.search("hello", "hello")
    assert result == [:green, :green, :green, :green, :green]
  end

  test "tests all gray" do
    result = Games.Wordle.search("aaaaa", "bbbbb")
    assert result == [:gray, :gray, :gray, :gray, :gray]
  end
  test "tests all yellow" do
    result = Games.Wordle.search("abcde", "bcdea")
    assert result == [:yellow, :yellow, :yellow, :yellow, :yellow]
  end
  test "test one green" do
    result = Games.Wordle.search("hello", "hxxxx")
    assert result == [:green, :gray, :gray, :gray, :gray]
  end
  test "test one yellow" do
    result = Games.Wordle.search("aaaba", "cbccc")
    assert result == [:gray, :yellow, :gray, :gray, :gray]
  end
  test "test one tricky" do
    result = Games.Wordle.search("light", "hello")
    assert result == [:yellow, :gray, :yellow, :gray, :gray]
  end
  test "test two tricky" do
    result = Games.Wordle.search("hello", "style")
    assert result == [:gray, :gray, :gray, :green, :yellow]
  end
end
