defmodule HighRoller.MixProject do
  use Mix.Project

  def project do
    [
      app: :high_roller,
      version: "1.0.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test],
      description: "A Dice Roller"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:credo, "~> 1.2", only: [:dev, :test], runtime: false},
      {:mox, "~> 0.5", only: :test},
      {:excoveralls, "~> 0.12.3", only: :test}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/NateBarnes/high_roller",
        "Docs" => "https://hexdocs.pm/high_roller/0.4.1"
      }
    ]
  end

  defp elixirc_paths(:test), do: ["test/support", "lib"]
  defp elixirc_paths(_),     do: ["lib"]
end
