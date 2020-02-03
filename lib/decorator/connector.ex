defmodule Decorator.Connector do
  @moduledoc false

  import Decorator.Util.Key
  alias Decorator.Config.Store
  alias :gen_tcp, as: GenTCP

  @doc """
  Listen for requests.
  """
  @spec listen :: :ok | {:error, atom}
  def listen do
    # set up listener environment
    unix_socket = Store.value(~k[default.listener.unix.socket])
    if File.exists?(unix_socket), do: File.rm!(unix_socket)
    # see :inet.local_address()
    local_address = {:ifaddr, {:local, unix_socket}}

    listener_options = [
      local_address | [:binary, active: false, reuseaddr: true, packet: :line]
    ]

    # accept incomming requests
    {:ok, listener} = GenTCP.listen(0, listener_options)
    accept(listener)
  end

  defp accept(listener) do
    {:ok, connection} = GenTCP.accept(listener)

    {:ok, pid} =
      Task.Supervisor.start_child(
        Decorator.Shell.Supervisor,
        fn -> handle(connection) end
      )

    :ok = GenTCP.controlling_process(connection, pid)

    accept(listener)
  end

  defp handle(connection) do
    connection
     |> request()
     |> response(connection)
  end

  defp request(connection) do
    {:ok, request} = GenTCP.recv(connection, 0)
    request
  end

  defp response(response, connection) do
    GenTCP.send(connection, response)
  end
end
