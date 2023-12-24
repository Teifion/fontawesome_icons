defmodule Fontawesome.MixProject do
  use Mix.Project

  @github_url "https://github.com/Teifion/fontawesome_icons"
  @version "0.0.1"

  def project do
    [
      app: :fontawesome_icons,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      # Hex
      description: "Phoenix Components for FontAwesome icons",
      package: package()
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
      {:phoenix_live_view, "~> 0.18.16"}
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
end
