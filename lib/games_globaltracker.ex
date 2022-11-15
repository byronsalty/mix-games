defmodule Games.GlobalScoreTracker do
  use GenServer

  def start_link(state \\ %{}) do
    IO.puts("Starting Games.GlobalScoreTracker")
    opts = [name: __MODULE__]
    GenServer.start_link(__MODULE__, state, opts)
  end
  def add(game, player, amt) do
    GenServer.cast(__MODULE__, {:add, game, player, amt})
  end

  def get(game, player) do
    GenServer.call(__MODULE__, {:get, game, player})
  end

  def new(game, player) do
    GenServer.cast(__MODULE__, {:new, game, player})
  end

  @impl true
  def init(state) do
    {:ok, state}
  end


  @impl true
  def handle_cast({:new, game, player}, state) do
    new_state = if (Map.get(state, {game, player}, nil) == nil) do
      Map.put(state, {game, player}, 0)
    else
      %{state | {game, player} => 0}
    end
    {:noreply, new_state}
  end

  @impl true
  def handle_cast({:add, game, player, amt}, state) do
    new_state = if (Map.get(state, {game, player}, nil) == nil) do
      Map.put(state, {game, player}, amt)
    else
      new_score = state[{game, player}] + amt
      %{state | {game, player} => new_score}
    end
    {:noreply, new_state}
  end

  @impl true
  def handle_call({:get, game, player}, _from, state) do
    # {:reply, Map.get(state, {game, player}, 0), state}
    {:reply, Map.get(state, {game, player}, nil), state}
  end
end
