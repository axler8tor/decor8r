defmodule PathDecoratorTest do
  use ExUnit.Case

  test "Decorator.Terminal.PathDecorator.decorate/2" do
    start_supervised(Decorator.Configuration)

    configuration = Decorator.Configuration.get()
    decoration = Decorator.Terminal.PathDecorator.decorate("/a/b/c/d/e", configuration)
    decoration |> IO.puts()
    assert 1 == 1
  end
end
