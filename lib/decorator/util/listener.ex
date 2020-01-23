defmodule Decorator.Util.Listener do
  @moduledoc false

  use GenServer
  import Decorator.Util.Key
  alias Decorator.Config.Store
  # alias :gen_tcp, as: GenTCP

  # TODO: Document. Refer to :gen_tcp and :inet
  @type listener_options :: [
          {:ifaddr, local: String.t()}
          | :binary
          | {:active, false}
          | {:reuseaddr, true}
          | {:packet, 4}
        ]
  @type reason :: any

  @spec start_link(any) :: :ignore | {:error, reason} | {:ok, pid}
  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: __MODULE__)
  end

  @impl true
  @spec init(any) :: {:ok, listener_options}
  def init(_) do
    socket = Store.value(~k[default.listener.unix.socket])

    state = [
      {:ifaddr, local: socket},
      :binary,
      active: false,
      reuseaddr: true,
      packet: 4
    ]

    {:ok, state}
  end
end
