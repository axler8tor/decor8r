defmodule Decorator.Connector do
  @moduledoc false

  import Decorator.Util.Key
  alias Decorator.Config.Store
  alias :gen_tcp, as: GenTCP

  @doc """
  Listen for incomming connections.
  """
  @spec listen :: :ok | {:error, atom}
  def listen do
    socket_descriptor = {
      :ifaddr,
      {:local, Store.value(~k[default.listener.unix.socket])}
    }

    listener_options = [
      socket_descriptor | [:binary, active: false, reuseaddr: true, packet: 4]
    ]

    {:ok, listener} = GenTCP.listen(0, listener_options)
    accept(listener)
  end

  @doc """
  Accept requests.
  """
  @spec accept(port) :: :ok | {:error, atom}
  def accept(listener) do
    {:ok, connection} = GenTCP.accept(listener)
    handle(connection)
  end

  @doc """
  Handle requests.
  """
  @spec handle(port) :: :ok | {:error, atom}
  def handle(connection) do
    connection |> request() |> response(connection)
  end

  defp request(connection) do
    {:ok, request} = GenTCP.recv(connection, 0)
    request
  end

  defp response(response, connection) do
    GenTCP.send(connection, response)
  end
end
