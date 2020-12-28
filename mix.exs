defmodule Heap.Mixfile do
  use Mix.Project

  @version "2.0.2"

  def project do
    [
      app: :heap,
      version: @version,
      description: description(),
      elixir: "~> 1.5",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [extra_applications: [:logger]]
  end

  def description do
    "Small composable Heap implementation. Heaps sort elements at insert time."
  end

  def package do
    [
      maintainers: ["James Harton <james@harton.nz>"],
      licenses: ["MIT"],
      links: %{
        "Repository" => "https://gitlab.com/jimsy/heap",
        "Docs" => "https://hexdocs.pm/heap"
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
      {:ex_doc, ">= 0.0.0", only: ~w[dev test]a},
      {:earmark, ">= 0.0.0", only: ~w[dev test]a},
      {:credo, "~> 1.0", only: ~w[dev test]a, runtime: false},
      {:git_ops, "~> 2.3", only: ~w[dev test]a, runtime: false}
    ]
  end
end
