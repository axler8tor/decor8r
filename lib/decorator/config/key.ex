defmodule Decorator.Config.Key do
  @moduledoc false

  @spec sigil_k(binary, any) :: [atom]
  def sigil_k(key, _opts) when is_binary(key) do
    key |> String.split(".") |> Enum.map(&String.to_atom(&1))
  end
end
