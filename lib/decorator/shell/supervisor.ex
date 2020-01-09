defmodule Decorator.Shell.Supervisor do
    use Supervisor

    def start_link(opts) do
        Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
    end

    def init(_) do
        children = [
            {Decorator.Shell.Listener, name: Decorator.Shell.Listener},
            {Decorator.Shell.ZSH, name: Decorator.Shell.ZSH}
        ]

        Supervisor.init(children, strategy: :one_for_one)
    end
end