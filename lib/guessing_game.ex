defmodule Games.GuessingGame do
  @ans Enum.random(1..2)
  def start() do
    guess = IO.gets("Guess a number 1-10: ")

    if String.trim(guess) == "#{@ans}" do
      "Correct!"
    else
      "Wrong!"
    end
  end
end
