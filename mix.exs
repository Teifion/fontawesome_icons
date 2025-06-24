defmodule Fontawesome.MixProject do
  use Mix.Project

  @source_url "https://github.com/Teifion/fontawesome_icons"
  @version "0.0.8"

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

      # Docs
      name: "Fontawesome Icons",
      docs: [
        main: "Fontawesome",
        api_reference: false,
        # logo: "assets/teiserver-logo.svg",
        source_ref: "v#{@version}",
        source_url: @source_url,
        extra_section: "GUIDES",
        formatters: ["html"],
        extras: extras(),
        # groups_for_extras: groups_for_extras(),
        # groups_for_modules: groups_for_modules(),
        # groups_for_docs: groups_for_docs(),
        skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
      ]
    ]
  end

  defp extras do
    [
      "CHANGELOG.md": [title: "Changelog"]
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:makeup_eex, ">= 0.1.1", only: :docs},
      {:makeup_diff, "~> 0.1", only: :docs}
    ]
  end

  defp package do
    [
      maintainers: ["Teifion Jordan"],
      licenses: ["MIT"],
      links: %{
        "Changelog" => "#{@source_url}/blob/master/changelog.md",
        "GitHub" => @source_url
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
