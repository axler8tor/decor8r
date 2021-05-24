defmodule Decorator.MixProject do
  use Mix.Project

  def project do
    [
      app: :decor8r,
      version: "0.2.2",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # QC
      aliases: aliases(),
      dialyzer: [
        plt_file: {:no_warn, "_dialyzer/plts/dialyzer.plt"},
        ignore_warnings: ".dialyzer_ignore.exs"
      ],

      # Documentation
      source_url: "https://github.com/axler8tor/decor8r",
      docs: [
        extras: [
          "README.md"
        ]
      ]
    ]
  end

  def application do
    [
      # extra_applications: [:logger],
      # mod: {Decorator.Application, []}
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.2.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:toml, "~> 0.6.1"},
      {:ex_doc, "~> 0.21", only: :dev, runtime: false}
    ]
  end

  defp aliases() do
    [
      qc: ["format", "dialyzer", "credo --strict"]
    ]
  end
end
