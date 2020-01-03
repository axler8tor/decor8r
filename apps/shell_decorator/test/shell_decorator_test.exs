defmodule ShellDecoratorTest do
  use ExUnit.Case
  doctest ShellDecorator

  test "greets the world" do
    assert ShellDecorator.hello() == :world
  end
end
