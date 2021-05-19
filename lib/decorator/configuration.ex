defmodule Decorator.Configuration do
  @moduledoc false

  use GenServer

  # TODO: The path shoud be an environment setting
  @default_config_file Path.expand("~/.config/decor8r/config.toml")

  @type file :: String.t()
  @type key :: list(atom)
  @type value :: boolean | integer | String.t() | list | map
  @type reason :: {:config_error, any} | any

  @spec start_link() :: :ignore | {:error, any} | {:ok, pid}
  @spec start_link(file) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(config_file \\ @default_config_file) do
    GenServer.start_link(__MODULE__, config_file, name: __MODULE__)
  end

  # API

  @spec value(key) :: value
  def value(key) when is_list(key) do
    GenServer.call(__MODULE__, {:value, key})
  end

  # Impl

  defp read(config_file) do
    if not File.exists?(config_file), do: initialise(config_file)

    with {:ok, content} <- File.read(config_file),
         {:ok, toml} <- Toml.decode(content, keys: :atoms) do
      toml
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp initialise(config_file) do
    File.mkdir_p!(Path.dirname(config_file))
    File.write!(config_file, config_file_content())
  end

  defp config_file_content, do: File.read!(Path.join(:code.priv_dir(:decor8r), "config.toml"))

  # Callbacks

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker
    }
  end

  @impl true
  @spec init(file) :: {:ok, map}
  def init(store) do
    {:ok, read(store)}
  end

  @impl true
  def handle_call({:value, key}, _from, state) do
    {:reply, get_in(state, key), state}
  end
end
