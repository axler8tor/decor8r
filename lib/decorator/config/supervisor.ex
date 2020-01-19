defmodule Decorator.Config.Supervisor do
  @moduledoc false

  use Supervisor

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  @spec init(any) :: {:ok, {%{intensity: any, period: any, strategy: any}, [any]}}
  def init(_) do
    children = [
      Decorator.Config.Store,
      Decorator.Config.Listener
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
