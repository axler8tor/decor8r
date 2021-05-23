defmodule Decorator.Utility.Key do
  @moduledoc """
  #{__MODULE__} provides a convinience sigil – `sigil_k/2` – to convert paths,
  as used in keyword maps into a list of atoms to pass ot `Kernet.get_in/2`.


  ## Examples
      iex> map = %{a: %{deeply: %{nested: %{value: true}}}}
      %{a: %{deeply: %{nested: %{value: true}}}}

      iex> map.a.deeply.nested.value
      true

      iex> get_in(map, [:a, :deeply, :nested, :value])
      true

      iex> import #{__MODULE__}
      #{__MODULE__}
      iex> get_in(map, ~k[a.deeply.nested.value])
      true
  """

  @typedoc """
  A fully qualified path of terms, separated by dots.


  ## Examples

      part.another_part.last_part
  """
  @type key :: String.t()

  @typedoc """
  A list of options. Currently ignored and aliased to `any`.
  """
  @type opts :: keyword()

  @doc """
  Convers a dot separated path of terms into a list of atoms.


  ## Examples

      iex> ~k[path.to.value]
      [:path, :to, :value]
  """
  @spec sigil_k(key) :: [:atom]
  @spec sigil_k(key, opts) :: [:atom]
  def sigil_k(key, _opts \\ []) when is_binary(key) do
    key |> String.split(".") |> Enum.map(&String.to_atom(&1))
  end
end
