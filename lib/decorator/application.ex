defmodule Decorator.Application do
  @moduledoc false

  use Application

  @spec start(any, any) :: {:ok, pid} | {:error, any}
  def start(_type, _args) do
    children = [
      Decorator.Config.Store,
      {Task.Supervisor, name: Decorator.Shell.Supervisor},
      {Task, fn -> Decorator.Connector.listen() end}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
