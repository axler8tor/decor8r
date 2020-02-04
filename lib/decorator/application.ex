defmodule Decorator.Application do
  @moduledoc false

  use Application

  @spec start(any, any) :: {:ok, pid} | {:error, any}
  def start(_type, _args) do
    children = [
      Decorator.Config.Store,
      {Task.Supervisor, name: Decorator.Listener.Supervisor},
      # TODO: figure out how hot name the listener `Decorator.Listener`
      {Task, fn -> Decorator.Listener.listen() end}
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
