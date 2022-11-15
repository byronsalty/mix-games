defmodule Games.GlobalScoreTracker.Test do
  use ExUnit.Case

  describe "init tests" do
    test "init with value" do
      {:ok, _} = Games.GlobalScoreTracker.start_link(%{{:game, :player} => 10})
      assert Games.GlobalScoreTracker.get(:game, :player) == 10
    end

    test "with empty map" do
      {:ok, _} = Games.GlobalScoreTracker.start_link(%{})
      assert Games.GlobalScoreTracker.get(:game, :player) == nil
    end

    test "with no map" do
      {:ok, _} = Games.GlobalScoreTracker.start_link()
      assert Games.GlobalScoreTracker.get(:game, :player) == nil
    end
  end

  describe "getter tests" do
    test "getter with init value" do
      {:ok, _} = Games.GlobalScoreTracker.start_link(%{{:game, :player} => 10})
      assert Games.GlobalScoreTracker.get(:game, :player) == 10
    end
    test "getter with no value found" do
      {:ok, _} = Games.GlobalScoreTracker.start_link(%{})
      assert Games.GlobalScoreTracker.get(:game, :player) == nil
    end
  end

  describe "adder tests" do
    test "adding to existing" do
      {:ok, _} = Games.GlobalScoreTracker.start_link(%{{:game, :player} => 10})
      Games.GlobalScoreTracker.add(:game, :player, 10)
      assert Games.GlobalScoreTracker.get(:game, :player) == 20
    end
    test "adding new value" do
      {:ok, _} = Games.GlobalScoreTracker.start_link(%{})
      Games.GlobalScoreTracker.add(:game, :player, 10)
      assert Games.GlobalScoreTracker.get(:game, :player) == 10
    end
  end

end
