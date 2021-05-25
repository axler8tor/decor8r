defmodule Decorator.Terminal.PathDecorator do
  @moduledoc false

  def decorate(path, configuration) do
    path
    |> String.split(~S[/], trim: true)
    |> Enum.join(" #{configuration.glyph.ltr.separator} ")
    |> do_decorate()
  end

  defp do_decorate(path) do
    IO.ANSI.blue_background() <> IO.ANSI.white() <> path <> IO.ANSI.reset()
  end
end
