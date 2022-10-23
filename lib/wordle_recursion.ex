defmodule Games.WordleRecur do

  @doc """
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

  # ["h", "e", "x", "o", "x"] || ["h", "e", "l", "l", "o"]
  # zip
  # [{"h", "h"}, {"e", "e"}, {"x", "l"}, {"o", "l"}, {"x", "o"}]
  defp check_green({ans, guess}) do
    Enum.zip(ans, guess)
    |> Enum.map(fn {a, g} -> if a == g, do: {:green, :green}, else: {a,g} end)
    |> Enum.unzip()
  end

  # With recursion
  defp check_yellow({ans, guess}) do
    {ans, recurse_yellow(ans, guess)}
  end
  defp recurse_yellow(_, []) do
    []
  end
  defp recurse_yellow(ans, guess) do
    [letter | rest] = guess
    if is_binary(letter) and Enum.member?(ans, letter) do
      [:yellow] ++ recurse_yellow(ans -- [letter], rest)
    else
      [letter] ++ recurse_yellow(ans, rest)
    end
  end

  defp check_gray({ans, guess}) do
    guess = guess |> Enum.map(fn g -> if is_binary(g), do: :gray, else: g end)
    {ans, guess}
  end
end
