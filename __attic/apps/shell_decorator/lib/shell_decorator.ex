defmodule ShellDecorator do
  @moduledoc false

  require Logger

  def listen(port \\ 65521) do
    Logger.info("Listen for shell requests")
    {:ok, socket} = :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])
    accept(socket)
  end

  defp accept(socket) do
    Logger.info("Accept shell request")
    {:ok, shell} = :gen_tcp.accept(socket)
    handle(shell)
    accept(socket)
  end

  defp handle(shell) do
    Logger.info("Handle shell request")
    shell
    |> rx()
    |> tx(shell)

    handle(shell)
  end

  defp rx(socket) do
    Logger.info("Read request from shell")
    {:ok, data} = :gen_tcp.recv(socket, 0)
    data
  end

  defp tx(line, socket) do
    Logger.info("Write response to shell")
    :gen_tcp.send(socket, line)
  end
end
