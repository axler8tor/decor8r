defmodule PathTest do
  use ExUnit.Case

  test "replace home path with tilde" do
    path = Decorator.Terminal.Path.new("/home/someone/path")
    rhs = "~/path"
    lhs = Decorator.decorate(path)

    assert lhs == rhs
  end
end
