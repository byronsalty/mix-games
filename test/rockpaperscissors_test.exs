defmodule Games.RockPaperScissors.Test do
  use ExUnit.Case
  doctest Games.RockPaperScissors

  test "winners/2 returns :you when you win" do
    assert Games.RockPaperScissors.winners(:rock, :scissors) == :you
    assert Games.RockPaperScissors.winners(:paper, :rock) == :you
    assert Games.RockPaperScissors.winners(:scissors, :paper) == :you
  end

  test "winners/2 returns :opp when you lose" do
    assert Games.RockPaperScissors.winners(:rock, :paper) == :opp
    assert Games.RockPaperScissors.winners(:paper, :scissors) == :opp
    assert Games.RockPaperScissors.winners(:scissors, :rock) == :opp
  end

  test "winners/2 returns :tie when you tie" do
    assert Games.RockPaperScissors.winners(:rock, :rock) == :tie
    assert Games.RockPaperScissors.winners(:paper, :paper) == :tie
    assert Games.RockPaperScissors.winners(:scissors, :scissors) == :tie
  end
end
