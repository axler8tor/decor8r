defmodule Decorator.Config.Listener do
  use GenServer

  @this __MODULE__

  def start_link do
    GenServer.start_link(@this, :ok, name: @this)
  end

  def child_spec(_) do
    %{
      id: @this,
      start: {@this, :start_link, []},
      type: :worker
    }
  end

  def init(:ok) do
    {:ok, %{}}
  end
end
