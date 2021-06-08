defmodule AxlER8R.IEX.Helper do
  def history_file() do
    :filename.basedir(:user_cache, "erlang-history")
  end
end

alias AxlER8R.IEX.Helper, as: Ax
