defmodule Decorator.Config.Store do
  use GenServer
  @moduledoc false

  @store Path.expand("~/.config/decor8r/config.toml")

  @type file :: String.t()
  @type key :: String.t()
  @type value :: boolean | atom | integer | String.t() | list | map
  @type reason :: {:config_error, term} | term

  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_arg, name: __MODULE__)
  end

  # API

  @doc """
  Initialize a new configuration store.
  """
  @spec load() :: :ok | {:error, reason}
  @spec load(file) :: :ok | {:error, reason}
  def load(store \\ @store) do
    GenServer.call(__MODULE__, {:load, store})
  end

  # Implementation

  defp initialise(store) do
    File.mkdir(Path.dirname(store))
    File.write(@store, file_content())
  end

  defp file_content do
    ~S"""
    title = "decor8r Configuration"

    [meta]
    version = "0.1.5"

    [shell]
    theme = "Material Pale Night"

    [shell.listener]
    port = 65521
    socket = "/tmp/decor8r.sock"

    [shell.glyph.separator]
    start = " "       # TODO: replace with unicode
    separator = ""   # TODO: replace with unicode
    stop = ""        # TODO: replace with unicode

    [shell.glyph.vcs]
    branch = ""      # TODO: replace with unicode
    add = ""          # TODO: replace with unicode
    remove = ""       # TODO: replace with unicode
    change = ""       # TODO: replace with unicode
    """
  end

  defp read(store) do
    content =
      case File.read(store) do
        {:ok, file_content} -> file_content
        _ -> ""
      end

    case Toml.decode(content, keys: :atoms) do
      {:ok, toml} -> toml
      error -> error
    end
  end

  # Callbacks

  @impl true
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:load, store}, _from, _state) do
    if not File.exists?(store), do: initialise(store)
    config = read(store)
    {:reply, :ok, config}
  end
end
