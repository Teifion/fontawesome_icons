defmodule Fontawesome do
  @moduledoc """

  To add as a dependency in your `mix.exs`:
  ```elixir
  def deps do
    [
      {:fontawesome_icons, "~> 0.0.8"}
    ]
  end
  ```

  Example usage:
  ```
  <Fontawesome.icon icon="arrow-left" />

  <Fontawesome.icon icon="icon2" style="solid" />

  <Fontawesome.icon icon="another-icon" weight="sharp" />

  <Fontawesome.icon
    icon="everything"
    style="thin"
    weight="sharp"
    size="2x"
    class="my-css-class"
    css="border: 1px solid red;"
    phx-click="do-something"
  />
  ```

  Has a single configuration option allowing you to register the free version only is used. When set this will (try to) override all non-free styling to be free only.
  ```elixir
  config :fontawesome_icons,
    free_only: true
  ```

  Additionally contains lists of icon names with `Fontawesome.regular_icons/0` and `Fontawesome.brand_icons/0`
  """
  use Phoenix.Component

  attr(:icon, :string, required: true)
  attr(:style, :string, default: "regular")
  attr(:weight, :string, default: nil)
  attr(:size, :string, default: nil)
  attr(:class, :any, default: nil)
  attr(:css, :string, default: nil)
  attr(:rest, :global)

  @doc """
  Returns a fontawesome icon as a Phoenix.LiveView.Rendered object.

  Requires:
    `icon`: The fontawesome icon you wish to display, you do not need to prefix it with "fa-"

  Optional arguments:
    `style`: regular, solid, light, thin, duotone or brand
    `weight`: classic or sharp
    `size`: the fx weight class, you do not need to prefix it with "fa-"
    `class`: css classes placed into the "class" attribute after the above classes
    `css`: css placed into the "style" attribute
  """
  @spec icon(map) :: Phoenix.LiveView.Rendered.t()
  def icon(assigns) do
    style =
      if Application.get_env(:fontawesome_icons, :free_only, false) do
        assigns[:style]
        |> fa_prefix()
        |> free_style()
      else
        fa_prefix(assigns[:style])
      end

    weight =
      if Application.get_env(:fontawesome_icons, :free_only, false) do
        assigns[:weight]
        |> fa_prefix()
        |> free_weight()
      else
        fa_prefix(assigns[:weight])
      end

    size = fa_prefix(assigns[:size])
    icon_name = fa_prefix(assigns[:icon])

    assigns =
      assigns
      |> assign(:class, "fa-fw #{style} #{size} #{weight} #{icon_name} #{assigns[:class]}")

    ~H"""
    <i class={@class} style={@css} {@rest}></i>
    """
  end

  # Prefixes the relevant word with "fa-" if it is not already prefixed so
  defp fa_prefix("fa-" <> s), do: "fa-" <> s
  defp fa_prefix(""), do: ""
  defp fa_prefix(nil), do: nil
  defp fa_prefix(s), do: "fa-" <> s

  # Used to make the styling of icons limited to the free version
  defp free_style("fa-brand"), do: "fa-brand"
  defp free_style(""), do: ""
  defp free_style(nil), do: nil
  defp free_style(_), do: "fa-solid"

  # Used to make the styling of icons limited to the free version
  defp free_weight(nil), do: nil
  defp free_weight(_), do: ""

  @doc """
  Returns a list of all the brand icons
  """
  @spec brand_icons() :: [String.t()]
  defdelegate brand_icons(), to: Fontawesome.BrandIcons

  @doc """
  Returns a list of all non-brand icons
  """
  @spec regular_icons() :: [String.t()]
  defdelegate regular_icons(), to: Fontawesome.RegularIcons

  @doc false
  require Logger

  def standard_icons() do
    Logger.warning("Fontawesome.standard_icons is being replaced by Fontawesome.regular_icons")
    Fontawesome.RegularIcons.regular_icons()
  end

  @doc """
  The version of FontAwesome this was built against (for the icon lists)
  """
  @spec version() :: String.t()
  def version(), do: "6.7.2"
end
