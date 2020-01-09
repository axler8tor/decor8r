defmodule ShellDecoratorTest do
  use ExUnit.Case
  doctest ShellDecorator

  setup do
    shell_listener = start_supervised!(ShellDecorator)
    %{shell_listener: shell_listener}
  end

  test "listen for incomming connections", %{shel_listener: shel_listener} do
    shel_listener |> IO.inspect
    assert true == true
  end
end
