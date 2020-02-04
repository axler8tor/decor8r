defprotocol Decoration do
  @type path :: Path.t()
  @type decoration :: String.t()

  @doc """
  TODO: write
  """
  @spec decorate(path) :: decoration
  def decorate(path)
end
