defmodule Games.ScoreTracker.Test do
  use ExUnit.Case

  describe "score/2" do
    test "adds the score to the current score" do
      {:ok, pid} = Games.ScoreTracker.start_link()
      assert Games.ScoreTracker.get_score(pid) == 0
      Games.ScoreTracker.score(pid, 10)
      assert Games.ScoreTracker.get_score(pid) == 10
    end
  end

  describe "get_score/1" do
    test "tests the current score" do
      {:ok, pid} = Games.ScoreTracker.start_link()
      assert Games.ScoreTracker.get_score(pid) == 0
    end
  end
end
