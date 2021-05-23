defprotocol Decorator do
  @type object :: struct()
  @type decoration :: String.t()

  @doc """
  Decorates part, or all of a shell prompt, vim status line or tmux status line.
  """
  @spec decorate(object()) :: decoration()
  def decorate(object)
end
