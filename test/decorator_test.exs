defmodule DecoratorTest do
  use ExUnit.Case
  doctest Decorator

  test "test path" do
    assert Decorator.hello() == :world
  end
end
