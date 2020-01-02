defmodule Configurator do
  @moduledoc false

  import Toml

  @config_dir Path.expand("~/.config/decor8r")
  @config_file Path.join(@config_dir, "config.toml")
  @config """
  [shell]
  foreground = "default"
  background = "default"
  """

  def config_dir() do
    @config_dir
  end

  defp config_file_exists?() do
    File.exists?(@config_file)
  end

  defp create_and_populate_default_config_file() do
    File.mkdir(@config_dir)
    File.write(@config_file, @config)
  end

  defp load_config_file() do
    :ok
  end

  def init() do
    if not config_file_exists?(), do: create_and_populate_default_config_file()
    load_config_file()
  end

  def check() do
    Toml.decode_file(@config_file)
  end
end
