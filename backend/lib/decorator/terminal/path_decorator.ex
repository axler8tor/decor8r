defmodule Decorator.Terminal.Directory do
  @spec decorate(binary) :: binary
  def decorate(directory) do
    directory
    |> String.split(~S[/], trim: true)
    |> Enum.join("  ")
    |> do_decorate()
  end

  defp do_decorate(directory) do
    IO.ANSI.blue_background() <> IO.ANSI.white() <> directory <> IO.ANSI.reset()
  end
end
