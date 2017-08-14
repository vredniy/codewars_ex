defmodule CodewarsEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :codewars_ex,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: [:plug,
                     :cowboy,
                     :ranch,
                     :logger,
                     :gproc
                    ],
      mod: {CodewarsEx, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.1"},
      {:plug, "~> 1.4"},
      {:poison, "~> 3.1"},
      {:gproc, "~> 0.6"}
    ]
  end
end
