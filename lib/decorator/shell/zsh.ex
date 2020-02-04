defmodule Decorator.Shell.ZSH do
  @moduledoc false

  @type path :: Path.t()
  @type decoration :: String.t()

  @spec decorate(path) :: decoration
  def decorate(path) do
    "result"
  end
end
