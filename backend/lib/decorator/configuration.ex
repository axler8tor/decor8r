defmodule Decorator.Configuration do
  @moduledoc """
  Load, present and reload configuration information.
  """
  use GenServer

  # API
  @spec start_link() :: :ignore | {:error, any()} | {:ok, pid()}
  @spec start_link(any()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start_link(_state\\nil) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @doc """
  Reteive configuration map.
  """
  @spec get() :: map()
  def get() do
    GenServer.call(__MODULE__, :get)
  end

  @doc """
  Reteive specific configuration as specified by key path.
  """
  @spec get_at(list(atom)) :: any()
  def get_at(key) do
    Kernel.get_in(get(), key)
  end

  # Callbacks
  @spec init(any()) :: {:ok, map()}
  @impl true
  def init(_nostate) do
    {:ok, Toml.decode_file!("priv/config.toml", keys: :atoms)}
  end

  @impl true
  def handle_call(:get, _from, config) do
    {:reply, config, config}
  end
end

defmodule Decorator.Configuration.Key do
  @moduledoc """
  Helpers to simplify access to configuration data
  """

  @doc """
  TODO
  """
  @spec sigil_k(binary()) :: list(atom)
  @spec sigil_k(binary(), list()) :: list(atom)
  def sigil_k(key, _options\\[]), do: key |> to_atoms()

  @doc """
  TODO
  """
  @spec to_atoms(binary()) :: list(atom)
  @spec to_atoms(binary(), list()) :: list(atom)
  def to_atoms(key, _options\\[]) do
    key
    |> String.split(".")
    |> Enum.map(&String.to_atom/1)
  end
end
