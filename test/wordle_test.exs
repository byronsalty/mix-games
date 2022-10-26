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

  @tag timeout: 120000
  @tag :benchmark
  test "testing 5x inputs to see how performance changes" do
    Benchee.run(%{

      "Reduce Wordle abcde 5 yellow" => fn -> Games.Wordle.search("abcde", "bcdea") end,
      "Reduce Wordle with 25 yellow" => fn -> Games.Wordle.search("abcdefghijklmnopqrstuvwxy", "bcdefghijklmnopqrstuvwxya") end
    })
  end

  # @tag timeout: 120000
  # @tag :benchmark
  # test "search/2 benchmark" do
  #   Benchee.run(%{
  #     # "Reduce Wordle hello with hello" => fn -> Games.Wordle.search("hello", "hello") end,
  #     # "Reduce Wordle abcde with fghij" => fn -> Games.Wordle.search("abcde", "fghij") end,
  #     # "Reduce Wordle hello with style" => fn -> Games.Wordle.search("hello", "style") end,
  #     # "Reduce Wordle hello with hoard" => fn -> Games.Wordle.search("hello", "hoard") end,
  #     "Reduce Wordle abcde 5 yellow" => fn -> Games.Wordle.search("abcde", "bcdea") end,
  #     "Reduce Wordle with 25 yellow" => fn -> Games.Wordle.search("abcdefghijklmnopqrstuvwxy", "bcdefghijklmnopqrstuvwxya") end

  #     # "All Green" => fn -> Games.Wordle.search("aaaaa", "aaaaa") end,
  #     # "All Grey" => fn -> Games.Wordle.search("lapse", "quick") end,
  #     # "All Yellow" => fn -> Games.Wordle.search("lapse", "alsep") end,
  #     # "3 Green 2 Yellow" => fn -> Games.Wordle.search("lapse", "lapes") end,
  #     # "4 Grey 1 Yellow" => fn -> Games.Wordle.search("lapse", "xzwts") end,
  #     # "3 Grey 2 Yellow" => fn -> Games.Wordle.search("lapse", "xzwas") end,
  #     # "3 Green 2 Grey" => fn -> Games.Wordle.search("lapse", "lapzq") end
  #   })
  # end


  # @tag :benchmark
  # test "search/2 benchmark w/ recursion" do
  #   Benchee.run(%{
  #     "Recurse Wordle hello with hello" => fn -> Games.WordleRecur.search("hello", "hello") end,
  #     "Recurse Wordle abcde with fghij" => fn -> Games.WordleRecur.search("abcde", "fghij") end,
  #     "Recurse Wordle hello with style" => fn -> Games.WordleRecur.search("hello", "style") end,
  #     "Recurse Wordle with shifted alpha" => fn -> Games.Wordle.search("abcdefghijklmnopqrstuvwxyx", "bcdefghijklmnopqrstuvwxyxa") end,
  #     "Recurse Wordle hello with hoard" => fn -> Games.WordleRecur.search("hello", "hoard") end
  #   })
  # end
end
