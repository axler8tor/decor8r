defmodule Decorator.Terminal.PathDecorator do
  @moduledoc false

  defstruct background: IO.ANSI.normal(),
            foreground: IO.ANSI.normal(),
            compact: :true,
            boldlast: :true,
            softstop: ""

  @spec decorate(binary) :: binary
  def decorate(path) do
    path
    |> String.split(~S[/], trim: true)
    |> Enum.join("  ")
    |> do_decorate()
  end

  defp do_decorate(path) do
    IO.ANSI.blue_background() <> IO.ANSI.white() <> path <> IO.ANSI.reset()
  end
end
