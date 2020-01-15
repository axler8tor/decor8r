defmodule Decorator.Config.Key do
  @moduledoc """
  Key provides a convinience sigil to convert paths, as used in key maps into a
  list of atoms to pass ot Kernet.get_in/2.

  ## Examples

    iex> map = %{a: %{deeply: %{nested: %{value: true}}}}
    %{a: %{deeply: %{nested: %{value: true}}}}

    iex> map.a.deeply.nested.value
    true

    iex> get_in(map, [:a, :deeply, :nested, :value])
    true

    iex> get_in(map, ~k[a.deeply.nested.value])
    true
  """

  @doc """
  Convers a dot separated path of terms into a list of atoms.

  ## Examples

    iex> ~k[path.to.value]
    [:path, :to, :value]

  """
  @spec sigil_k(String.t(), any) :: [atom]
  def sigil_k(key, _opts) when is_binary(key) do
    key |> String.split(".") |> Enum.map(&String.to_atom(&1))
  end
end
