defmodule DecoratorTest do
  use ExUnit.Case
  doctest Decorator

  test "greets the world" do
    assert Decorator.hello() == :world
  end
end
