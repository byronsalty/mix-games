defmodule Games.WordleRecur do
  @moduledoc """
  Documentation for `Games.WordleRecur`.
  """

  @type letter :: binary | atom

  @spec search(binary, binary) :: [atom()]
  @doc """
  Searching

  ## Examples

    iex> Games.Wordle.search("hello", "hello")
    [:green, :green, :green, :green, :green]

    iex> Games.Wordle.search("aaaac", "bbbbc")
    [:gray, :gray, :gray, :gray, :green]
  """
  def search(ans, guess) do
    ans = String.downcase(ans) |> String.split("", trim: true)
    guess = String.downcase(guess) |> String.split("", trim: true)

    # ["h", "e", "x", "o", "x"] || ["h", "e", "l", "l", "o"]
    # check_green
    # [:green, :green, "x", "o", "x"] || [:green, :green, "l", "l", "o"]
    # check_yellow
    # ["h", "e", "x", "o", "x"] || [:green, :green, "l", "l", :yellow]

    {_, guess} =
      {ans, guess}
      |> check_green()
      |> check_yellow()
      |> check_gray()

    guess
  end

  @spec check_green({[letter], [letter]}) :: {[letter], [letter]}
  defp check_green({ans, guess}) do
    Enum.zip(ans, guess)
    |> Enum.map(fn {a, g} -> if a == g, do: {:green, :green}, else: {a, g} end)
    |> Enum.unzip()
  end

  @spec check_yellow({[letter], [letter]}) :: {[letter], [letter]}
  defp check_yellow({ans, guess}) do
    {ans, recurse_yellow(ans, guess)}
  end

  @spec recurse_yellow(any, []) :: []
  defp recurse_yellow(_, []) do
    []
  end

  @spec recurse_yellow([letter], [letter]) :: [letter]
  defp recurse_yellow(ans, guess) do
    [letter | rest] = guess

    if is_binary(letter) and Enum.member?(ans, letter) do
      [:yellow] ++ recurse_yellow(ans -- [letter], rest)
    else
      [letter] ++ recurse_yellow(ans, rest)
    end
  end

  @spec check_gray({[letter], [letter]}) :: {[letter], [letter]}
  defp check_gray({ans, guess}) do
    guess = guess |> Enum.map(fn g -> if is_binary(g), do: :gray, else: g end)
    {ans, guess}
  end
end
