defmodule Decorator.Configuration do
  use GenServer

  # API
  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @spec get() :: any()
  def get() do
    GenServer.call(__MODULE__, :get)
  end

  # Callbacks
  @spec init(any()) :: {:ok, map()}
  @impl true
  def init(_nostate) do
    {:ok, Toml.decode_file!("priv/config.toml", keys: :atoms)}
  end

  @impl true
  def handle_call(:get, _from, config) do
    {:reply, config, config}
  end
end
