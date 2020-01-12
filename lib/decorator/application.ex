defmodule Decorator.Application do
  @moduledoc false

  use Application

  @this __MODULE__

  @impl true
  def start(_type, _args) do
    children = [
      Decorator.Config.Supervisor,
      Decorator.Shell.Supervisor
    ]

    opts = [strategy: :one_for_one, name: @this]
    Supervisor.start_link(children, opts)
  end
end
