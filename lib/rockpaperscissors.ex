defmodule Games.RockPaperScissors do
  @moduledoc """
  Documentation for `Games.RockPaperScissors`.
  """

  @choices [:rock, :paper, :scissors]
  @you_win [rock: :scissors, paper: :rock, scissors: :paper]
  @you_lose [rock: :paper, paper: :scissors, scissors: :rock]

  @spec winners(atom(), atom()) :: :opp | :tie | :you
  def winners(you, opp) when {you, opp} in @you_win do
    :you
  end

  @spec winners(atom(), atom()) :: :opp | :tie | :you
  def winners(you, opp) when {you, opp} in @you_lose do
    :opp
  end

  @spec winners(atom(), atom()) :: :opp | :tie | :you
  def winners(_, _) do
    :tie
  end

  @spec start :: :ok
  def start() do
    opponent = Enum.random(@choices)
    IO.puts("Welcome to Rock Paper Scissors!")

    guess = get_input()
    IO.puts("You chose #{guess} and the opponent chose #{opponent}")

    case winners(guess, opponent) do
      :you -> IO.puts("You win!")
      :opp -> IO.puts("You lose!")
      :tie -> start()
    end
  end

  @spec get_input :: atom()
  def get_input() do
    choice = IO.gets("(rock/paper/scissors): ")
    choice = String.to_atom(String.trim(choice))

    if choice in @choices do
      choice
    else
      IO.puts("Invalid choice!")
      get_input()
    end
  end
end
