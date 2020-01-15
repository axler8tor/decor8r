defmodule Decorator.Config.Store do
  @moduledoc false

  use GenServer

  @store Path.expand("~/.config/decor8r/config.toml")

  @type file :: String.t()
  @type key :: String.t()
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
    with :ok <- File.mkdir(Path.dirname(store)),
         :ok <- File.write(store, file_content()) do
      :ok
    else
      {:error, error} -> {:error, error}
    end
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
end
