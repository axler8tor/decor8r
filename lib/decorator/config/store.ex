defmodule Decorator.Config.Store do
  @moduledoc false

  use GenServer

  @store Path.expand("~/.config/decor8r/config.toml")

  @type file :: String.t()
  @type key :: list(atom)
  @type value :: boolean | atom | integer | String.t() | list | map
  @type reason :: {:config_error, term} | term

  @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
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

  @spec config() :: map()
  def config do
    GenServer.call(__MODULE__, :config)
  end

  @spec value(key) :: value
  def value(key) when is_list(key) do
    GenServer.call(__MODULE__, {:key, key})
  end

  # Callbacks

  @impl true
  @spec init(any) :: {:ok, %{}}
  def init(_) do
    {:ok, %{}}
  end

  @impl true
  def handle_call({:load, store}, _from, _state) do
    {:reply, :ok, read(store)}
  end

  @impl true
  def handle_call(:config, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:key, key}, _from, state) do
    {:reply, get_in(state, key), state}
  end

  # Impl

  defp read(store) do
    if not File.exists?(store), do: initialise(store)

    with {:ok, content} <- File.read(store),
         {:ok, toml} <- Toml.decode(content, keys: :atoms) do
      toml
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp initialise(store) do
    with :ok <- File.mkdir_p(Path.dirname(store)),
         :ok <- File.write(store, file_content()) do
      :ok
    else
      {:error, error} -> {:error, error}
    end
  end

  defp file_content do
    ~S"""
    [about]
    version = "0.1.5"
    licence = "https://unlicense.org/"
    documentation = "https://decor8r.readthedocs.io/"
    homepage = "https://decor8r.axler8r.io/"
    source = "https://decor8r.axler8r.io/source/"
    bugs = "decor8r-bugs@axler8r.io"

    [theme]
    name = "Material Palenight"

    [shell]
    theme = "Material Pale Night"

    [shell.listener]
    port = 65521
    socket = "/tmp/decor8r.sock"

    [shell.decoration]
    segments = ["vi", "user", "path", "venv", "git", "status"]

    [shell.segment]
    [shell.segment.vi]
    [shell.segment.user]
    [shell.segment.path]
    [shell.segment.venv]
    [shell.segment.git]
    [shell.segment.status]

    """
  end
end
