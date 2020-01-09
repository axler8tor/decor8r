defmodule Decorator.Config.Supervisor do
    use Supervisor

    def start_link(opts) do
        Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
    end

    def init(_) do
        children = [
            {Decorator.Config.Store, name: Decorator.Config.Store},
            {Decorator.Config.Listener, name: Decorator.Config.Listener}
        ]

        Supervisor.init(children, strategy: :one_for_one)
    end
end