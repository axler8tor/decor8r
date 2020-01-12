defmodule ConfiguratorTest do
  use ExUnit.Case
  doctest Configurator

  test "create missing configuration store" do
    if File.exists?(Configurator.config_dir()), do: File.rm(Configurator.config_dir())
    assert Configurator.init() == :ok
  end

  test "check if configuration file is valid" do
    {check, _} = Configurator.check()
    assert check == :ok
  end
end
