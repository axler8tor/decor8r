defmodule ConfigServer do
  @moduledoc """
  Documentation for ConfigServer.
  """

  use GenServer

  def init(:ok) do
    {:ok, []}
  end

  @impl true
  def handle_call({:read, path}, _from, store) do
    {:reply, [], []}
  end
end
