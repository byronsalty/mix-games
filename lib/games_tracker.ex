defmodule Games.ScoreTracker do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, 0)
  end
  def add(pid, add) do
    GenServer.cast(pid, {:add, add})
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast({:add, score}, state) do
    new_state = state + score
    {:noreply, new_state}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end
end
