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

  test "feedback/2 mixture of grey and green" do
    assert Games.Wordle.search("zzdef", "badef") == [:gray, :gray, :green, :green, :green]
  end

  test "feedback/2 mixture of grey, green, and yellow" do
    assert Games.Wordle.search("zzdef", "badfe") == [:gray, :gray, :green, :yellow, :yellow]
  end

  test "should return green, yellow, grey based on the letter match and position" do
    result = Games.Wordle.search("fancy", "candy")
    assert result == [:yellow, :green, :green, :gray, :green]
  end

  test "test six letters" do
    result = Games.Wordle.search("abcdef", "fedcba")
    assert result == [:yellow, :yellow, :yellow, :yellow, :yellow, :yellow]
  end
end
