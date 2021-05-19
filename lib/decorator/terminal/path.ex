defmodule Decorator.Terminal.Path do
  alias __MODULE__

  @type t :: %Path {
    path: String.t(),
    background: IO.ANSI.ansicode(),
    foreground: IO.ANSI.ansicode(),
    path_separator: String.t(),
    path_compressor: String.t()
  }

  defstruct [
    path: nil,
    background: IO.ANSI.normal(),
    foreground: IO.ANSI.normal(),
    path_separator: "",
    path_compressor: "…"
  ]

  @spec new(String.t()) :: Decorator.Terminal.Path.t()
  def new(path) do
    %Path{path: path}
  end
end

defimpl Decorator, for: Decorator.Terminal.Path do
  @spec decorate(Decorator.object()) :: Decorator.decoration()
  def decorate(path) do
    {path}
    "Decorating a path!"
  end
end

defimpl Inspect, for: Decorator.Terminal.Path do
  @spec inspect(Decorator.Terminal.Path.t(), any()) :: String.t()
  def inspect(path, _opts) do
    """
    Path Specification:
      path: #{path.path}
      background: #{path.background}
      foreground: #{path.foreground}
      path_separator: #{path.path_separator}
      path_compressor: #{path.path_compressor}
    """
  end
end
