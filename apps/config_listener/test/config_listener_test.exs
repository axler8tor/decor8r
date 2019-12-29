defmodule ConfigListenerTest do
  use ExUnit.Case
  doctest ConfigListener

  test "greets the world" do
    assert ConfigListener.hello() == :world
  end
end
