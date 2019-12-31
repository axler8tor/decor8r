defmodule ConfigurationServerTest do
  use ExUnit.Case
  doctest ConfigurationServer

  test "greets the world" do
    assert ConfigurationServer.hello() == :world
  end
end
