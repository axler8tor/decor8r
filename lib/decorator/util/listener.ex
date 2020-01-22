defmodule Decorator.Util.Listener do
  @moduledoc false

  use GenServer
  import Decorator.Util.Key
  alias Decorator.Config.Store
  # alias :gen_tcp, as: GenTCP
  # alias :inet, as: Internet

  # TODO: Document. Refer to :gen_tcp and :inet
  @type listener_type :: :unix | :tcpip
  @type interface :: {:ifaddr, {:local, String.t()}}
  @type octect :: 0..255
  @type address :: [ip: [octect]]
  @type connection_type :: interface | address
  @type packet_size :: 4
  @type port_number :: integer
  @type listener_option :: [
          connection_type
          | :binary
          | {:active, false}
          | {:reuseaddr, true}
          | {:packet, packet_size}
        ]
  @type listener_options :: {port_number, [listener_option]}
  @type reason :: any

  @spec start_link() :: :ignore | {:error, reason} | {:ok, pid}
  @spec start_link(listener_type) :: :ignore | {:error, reason} | {:ok, pid}
  @spec start_link(listener_type, listener_option) :: :ignore | {:error, reason} | {:ok, pid}
  def start_link(
        listener_type \\ :unix,
        listener_option \\ [:binary, active: false, reuseaddr: true, packet: 4]
      ) do
    GenServer.start_link(__MODULE__, {listener_type, listener_option}, name: __MODULE__)
  end

  defp update_listener_options(:unix, listener_options) do
    socket_port = 0
    socket_name = Store.value(~k[default.listener.unix.socket])
    {socket_port, [{:ifaddr, {:local, socket_name}} | listener_options]}
  end

  defp update_listener_options(:tcpip, listener_options) do
    tcpip_port = Store.value(~k[default.listener.tcpip.port])
    {tcpip_port, [[ip: [127, 0, 0, 1]] | listener_options]}
  end

  @impl true
  @spec init({listener_type, listener_option}) :: {:ok, listener_options}
  def init({listener_type, listener_options}) do
    state = update_listener_options(listener_type, listener_options)
    {:ok, state}
  end
end
