defmodule Decorator.Listener do
  @moduledoc false

  import Decorator.Util.Key
  alias Decorator.Configuration
  alias :gen_tcp, as: GenTCP

  @doc """
  Entry point for all _decoration_ activity.

  Whenever a user issues a command in a terminal, performs some
  activity in Neovim or performs an action in a tmux session, a
  request is sent to `listen/0`. It then starts a _decorator_ to
  produce the approriate _decoration_ and return it to the caller for
  display.
  """
  @spec listen :: :ok | {:error, any}
  def listen do
    # set up listener environment
    unix_socket = Configuration.value(~k[decor8r.listener.unix.socket])
    if File.exists?(unix_socket), do: File.rm!(unix_socket)
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
        Decorator.Listener.Supervisor,
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
    case GenTCP.recv(connection, 0) do
      {:ok, request} -> request
      {:error, _} -> ""
    end
  end

  defp response(response, connection) do
    GenTCP.send(connection, response)
  end
end
