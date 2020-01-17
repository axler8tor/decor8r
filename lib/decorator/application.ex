defmodule Decorator.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Decorator.Config.Supervisor,
      Decorator.Shell.Supervisor
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    Supervisor.start_link(children, opts)
  end
end
