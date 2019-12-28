defmodule Decorator do
  def get_path do
    cwd = File.cwd()
    home = System.get_env("HOME")
    %{cwd: cwd, home: home}
  end

  def compress_path(cwd, home, depth \\ 5) do
    String.replace(cwd, home, "~")
  end

  def decorate(path) do
    green = "\\033[32m"
    normal = "\\033[0m"
    green <> path <> normal
  end
end

#%{cwd: {:ok, cwd}, home: home} = Decorator.get_path
#path = Decorator.compress_path(cwd, home)
#decorated_path = Decorator.decorate(path)
#IO.puts decorated_path
