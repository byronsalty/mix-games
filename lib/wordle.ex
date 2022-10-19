defmodule Games.Wordle do
  def search(ans, guess) do
    ans = String.downcase(ans) |> String.split("", trim: true)
    guess = String.downcase(guess) |> String.split("", trim: true)

    {_, guess} =
      {ans, guess}
      |> check_green()
      |> check_yellow()
      |> check_gray()

    guess
  end

  defp check_green({ans, guess}) do
    Enum.zip(ans, guess)
    |> Enum.map(fn {a, g} -> if a == g, do: {:green, :green}, else: {a,g} end)
    |> Enum.unzip()
  end
  defp check_yellow({ans, guess}) do
    if Enum.count(guess) == 0 do
      {ans, guess}
    else
      [letter | rest] = guess
      if is_binary(letter) and Enum.member?(ans, letter) do
        {ans, [:yellow] ++ elem(check_yellow({ans -- [letter], rest}), 1)}
      else
        {ans, [letter] ++ elem(check_yellow({ans, rest}), 1)}
      end
    end
  end
  defp check_gray({ans, guess}) do
    guess = guess |> Enum.map(fn g -> if is_binary(g), do: :gray, else: g end)
    {ans, guess}
  end
end
