defmodule OTC.Mixfile do
  use Mix.Project

  def project do
    [app: :otc,
     version: "0.0.1",
     elixir: "~> 1.2",
     escript: [main_module: OTC],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [
      :logger,
      :yaml_elixir,
    ]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [{:ex_spec, "~> 1.0.0", only: :test},
     {:the_fuzz, "~> 0.3.0"},
     {:yamerl, github: "yakaz/yamerl"},
     {:yaml_elixir, "~> 1.1.0"},
    ]
  end
end
