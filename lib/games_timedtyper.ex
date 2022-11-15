defmodule Games.TimedTyper do
  use GenServer

  @words ["def", "defmodule", "defstruct", "%{}", "Enum", "String", "__MODULE__", "Process", "IO.puts", "GenServer", "start_link", "handle_info", "handle_call", "handle_cast", "ExUnit", "mix", ":error", ":reply", ":noreply", "elixir", "livebook", "version", "Application", "describe", "test", "@impl", "@type", "@spec", "raise", "false", "true", "nil", "nil?", "is_nil", "is_atom", "is_binary", "is_boolean", "is_float", "is_function", "is_integer", "is_list", "is_map", "is_number", "is_pid", "is_port", "is_reference", "is_tuple", "is_bitstring", "is_nil"]
  @game :timedtyper
  @player :player1
  @starting_lives 3
  @wait_time_between_prompts 2000
  @timeout_wait_time_base 4000
  @timeout_wait_per_letter 200
  @timeout_reduce_per_question 200

  # Client API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    send(self(), :start)
    question_num = 1
    {:ok, {@starting_lives, @wait_time_between_prompts, question_num, false}}
  end

  # Didn't do this as a handle_info because I didn't want to change the state
  def do_ask(target_word) do
    # target_word = Enum.random(@words)
    typed_word = IO.gets("Type the word: \t #{target_word}\n") |> String.trim()
    send(Games.TimedTyper, {:eval, target_word == typed_word})
  end

  @impl true
  def handle_info(:start, state) do
    IO.puts("Starting new game!")
    Games.GlobalScoreTracker.new(@game, @player)
    send(self(), :prompt)
    {:noreply, state}
  end

  def handle_info(:prompt, {lives, wait_time, question_num, _}) do
    # send(self(), {:ask, question_num})
    target_word = Enum.random(@words)
    timeout_allowance =
      @timeout_wait_time_base +
      (String.length(target_word) * @timeout_wait_per_letter) -
      (@timeout_reduce_per_question * question_num)
    IO.puts("asking question number: #{question_num}")
    Process.send_after(self(), {:timeout, question_num}, timeout_allowance)
    spawn(fn -> do_ask(target_word) end)
    {:noreply, {lives, wait_time, question_num, false}}
  end

  def handle_info({:timeout, question_num}, {lives, wait_time, current_num, _}) do
    # if the question number is the same as the current question number then handle the timeout
    # IO.puts("Handling timeout: Q: #{question_num} State: #{current_num}")
    if (question_num == current_num) do
      # IO.puts("You took too long to answer!")
      # send(self(), {:eval, current_num+1, false})
      {:noreply, {lives, wait_time, current_num, true}}
    else
      {:noreply, {lives, wait_time, current_num, false}}
    end
  end

  # def handle_info(:ask, state) do
  #   target_word = Enum.random(@words)
  #   typed_word = IO.gets("Type the word: #{target_word}\n") |> String.trim()
  #   send(self(), {:eval, target_word == typed_word})
  #   {:noreply, state}
  # end

  @impl true
  def handle_info({:eval, good}, {lives, wait_time, current_num, timed_out}) do
    #update lives
    IO.puts("")
    new_lives = if good and !timed_out do
      IO.puts("Correct!")
      Games.GlobalScoreTracker.add(@game, @player, 1)
      lives
    else
      if timed_out do
        IO.puts("You took too long!")
      else
        IO.puts("Incorrect!")
      end
      lives - 1
    end

    #output status
    score = Games.GlobalScoreTracker.get(@game, @player)
    IO.puts("Remaining lives: #{new_lives}\nScore: #{score}\n\n")

    #check if game is over
    if new_lives > 0 do
      Process.send_after(self(), :prompt, wait_time)

      {:noreply, {new_lives, wait_time - 50, current_num + 1, timed_out}}
    else
      IO.puts("Game over!")
      raise "game over"
    end
  end
end
