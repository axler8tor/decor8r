defmodule Decorator.Config.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = [
      Decorator.Config.Store,
      Decorator.Config.Listener
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
