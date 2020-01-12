defmodule Decorator.Shell.Supervisor do
    use Supervisor

    @this __MODULE__

    def start_link do
        Supervisor.start_link(@this, :ok, name: @this)
    end

    def child_spec(_) do
        %{
            id: @this,
            start: {@this, :start_link, []},
            type: :supervisor
        }
    end

    def init(_) do
        children = [
            Decorator.Shell.Listener,
            Decorator.Shell.ZSH,
        ]

        Supervisor.init(children, strategy: :one_for_one)
    end
end