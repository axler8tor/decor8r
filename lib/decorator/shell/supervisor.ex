defmodule Decorator.Shell.Supervisor do
  @moduledoc false

  use Supervisor

  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_) do
    children = [
      Decorator.Shell.Listener,
      Decorator.Shell.ZSH
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
