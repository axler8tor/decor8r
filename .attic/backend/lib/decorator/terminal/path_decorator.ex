defmodule Decorator.Terminal.PathDecorator do
  @moduledoc """
  Decorate Linux/MacOS paths with characters and colors as outlined in
  the configuration file.
  """

  require Logger
  import Decorator.Configuration.Key

  @doc """
  Decorate the command line.
  """
  @spec decorate(String.t(), map()) :: String.t()
  def decorate(path, configuration) do
    path_config = Decorator.Configuration.get_at(~k[terminal.sections.path])
    theme = Decorator.Configuration.get_at(~k[themes.theme])

    IO.inspect(path_config)
    IO.inspect(theme)

    background = [blue, green, reg] = hex_to_rgb("themes." <> theme <> "." <> path_config.background
    |> Decorator.Configuration.Key.to_atoms()
    |> Decorator.Configuration.get_at())
    #foreground = hex_to_rgb(path_config.foreground)

    IO.inspect(background)
    IO.inspect(reg)
    IO.inspect(green)
    IO.inspect(blue)
    #IO.puts(foreground)

    path
    |> String.split(~S[/], trim: true)
    |> Enum.join(" #{configuration.symbols.ltr.separator} ")
    |> do_decorate()
  end

  defp do_decorate(path) do
    IO.ANSI.blue_background() <> IO.ANSI.white() <> path <> IO.ANSI.reset()
  end

  defp hex_to_rgb(hex) do
    do_hex_to_rgb(hex, [])
  end

  defp do_hex_to_rgb("#" <> rest, acc) do
    do_hex_to_rgb(rest, acc)
  end

  defp do_hex_to_rgb(<<hex::binary-size(2)>> <> rest, acc) do
    {int, _} = Integer.parse(hex, 16)
    do_hex_to_rgb(rest, [int | acc])
  end

  defp do_hex_to_rgb("", acc), do: acc
end

# TODO: think about this functionality as a service. Each path
#       decoration section will have the same config. It can be
#       starged with it's state intact and just called over and over
#       again. You will ofcource need to think about reloading the
#       state to reflect underlying config file changes.
