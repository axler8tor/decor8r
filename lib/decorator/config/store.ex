defmodule Decorator.Config.Store do
  @moduledoc false

  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_arg, name: __MODULE__)
  end

  @impl true
  def init(_) do
    {:ok, :ok}
  end
end
