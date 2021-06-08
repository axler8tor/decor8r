defmodule PathDecoratorTest do
  use ExUnit.Case

  test "Decorator.Terminal.PathDecorator.decorate/2" do
    start_supervised(Decorator.Configuration)

    configuration = Decorator.Configuration.get()
    lhs = Decorator.Terminal.PathDecorator.decorate("/a/b/c/d/e", configuration)
    rhs = IO.ANSI.blue_background() <> IO.ANSI.white() <> "a  b  c  d  e" <> IO.ANSI.reset()
    assert lhs == rhs
  end

  test "Test Configuration Map" do
    assert true == true
  end
end
