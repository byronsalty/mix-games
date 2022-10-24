defmodule Games.GuessingGame do
  @moduledoc """
  Documentation for `Games.GuessingGame`.
  """

  @ans Enum.random(1..2)
  @spec start :: String.t()
  def start() do
    guess = IO.gets("Guess a number 1-10: ")

    if String.trim(guess) == "#{@ans}" do
      "Correct!"
    else
      "Wrong!"
    end
  end
end
