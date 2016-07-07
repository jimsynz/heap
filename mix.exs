defmodule Heap.Mixfile do
  use Mix.Project

  def project do
    [app: :heap,
     version: "1.0.0",
     description: description,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [espec: :test],
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  def description do
    """
    Small composable Heap implementation. Heaps sort elements at insert time.
    They're good for:
      * Scientific computing
      * Statistics
      * Priority queues
    """
  end

  def package do
    [
      maintainers: [ "James Harton <james@messagerocket.co>" ],
      licenses: [ "MIT" ],
      links: %{
        "GitHub" => "https://github.com/jamesotron/heap",
        "Docs"   => "https://hexdocs.pm/heap"
      }
    ]
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
    [
      {:espec,    "~> 0.8.11", only: :test},
      {:ex_doc,   "~> 0.11.4", only: :dev}
    ]
  end
end
