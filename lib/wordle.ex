defmodule Games.Wordle do
  @moduledoc """
  Documentation for `Games.Wordle`.
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
    Enum.reduce(guess, {ans, []}, fn letter, {ans, acc} ->
      if is_binary(letter) and Enum.member?(ans, letter) do
        {ans -- [letter], acc ++ [:yellow]}
      else
        {ans, acc ++ [letter]}
      end
    end)
  end

  @spec check_gray({[letter], [letter]}) :: {[letter], [letter]}
  defp check_gray({ans, guess}) do
    guess = guess |> Enum.map(fn g -> if is_binary(g), do: :gray, else: g end)
    {ans, guess}
  end
end
