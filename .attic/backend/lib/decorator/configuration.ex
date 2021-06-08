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

defmodule Decorator.Configuration.Helper do
  @moduledoc """
  Helpers. All sorts of helpers.
  """

  @spec on_red :: <<_::24, _::_*8>>
  def on_red() do
    IO.ANSI.red_background()
  end

  @spec on_orange :: <<_::24, _::_*8>>
  def on_orange() do
    IO.ANSI.light_red_background()
  end

  @spec on_yellow :: <<_::24, _::_*8>>
  def on_yellow() do
    IO.ANSI.yellow_background()
  end

  @spec on_green :: <<_::24, _::_*8>>
  def on_green() do
    IO.ANSI.green_background()
  end

  @spec on_blue :: <<_::24, _::_*8>>
  def on_blue() do
    IO.ANSI.blue_background()
  end

  @spec on_cyan :: <<_::24, _::_*8>>
  def on_cyan() do
    IO.ANSI.cyan_background()
  end

  @spec on_magneta :: <<_::24, _::_*8>>
  def on_magneta() do
    IO.ANSI.magenta_background()
  end

  @spec on_violet :: <<_::24, _::_*8>>
  def on_violet() do
    IO.ANSI.light_magenta_background()
  end

  @spec on_base03 :: <<_::24, _::_*8>>
  def on_base03() do
    IO.ANSI.light_black_background()
  end

  @spec on_base02 :: <<_::24, _::_*8>>
  def on_base02() do
    IO.ANSI.black_background()
  end

  @spec on_base01 :: <<_::24, _::_*8>>
  def on_base01() do
    IO.ANSI.light_green_background()
  end

  @spec on_base00 :: <<_::24, _::_*8>>
  def on_base00() do
    IO.ANSI.light_yellow_background()
  end

  @spec on_base0 :: <<_::24, _::_*8>>
  def on_base0() do
    IO.ANSI.light_blue_background()
  end

  @spec on_base1 :: <<_::24, _::_*8>>
  def on_base1 do
    IO.ANSI.light_cyan_background()
  end

  @spec on_base2 :: <<_::24, _::_*8>>
  def on_base2() do
    IO.ANSI.white_background()
  end

  @spec on_base3 :: <<_::24, _::_*8>>
  def on_base3() do
    IO.ANSI.light_white_background()
  end
end
