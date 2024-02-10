defmodule Fontawesome.MixProject do
  use Mix.Project

  @github_url "https://github.com/Teifion/fontawesome_icons"
  @version "0.0.3"

  def project do
    [
      app: :fontawesome_icons,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),

      # Hex
      description: "Phoenix Components for FontAwesome icons",
      package: package(),

      name: "Fontawesome Icons"
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
      {:phoenix_live_view, ">= 0.18.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Teifion Jordan"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@github_url}/blob/master/changelog.md",
        "GitHub" => @github_url
      }
    ]
  end

  defp aliases do
    [
      release: [
        "cmd git tag v#{@version}",
        "cmd git push",
        "cmd git push --tags",
        "hex.publish --yes"
      ]
    ]
  end
end
