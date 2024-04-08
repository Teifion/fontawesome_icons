defmodule Fontawesome do
  @moduledoc ~S"""
  Example usage:

  ```
  <Fontawesome.icon icon="arrow-left" />

  <Fontawesome.icon icon="icon2" style="solid" />

  <Fontawesome.icon icon="another-icon" weight="sharp" />

  <Fontawesome.icon icon="everything" style="thin" weight="sharp" size="2x" class="my-css-class" css="border: 1px solid red;" />
  ```

  Has a single configuration option allowing you to register the free version only is used. When set this will (try to) override all non-free styling to be free only.
  ```elixir
  config :fontawesome,
    free_only: true
  ```

  Additionally contains a list of icons.
  """
  use Phoenix.Component

  attr(:icon, :string, required: true)
  attr(:style, :string, default: "regular")
  attr(:weight, :string, default: nil)
  attr(:size, :string, default: nil)
  attr(:class, :string, default: nil)
  attr(:css, :string, default: nil)

  @doc """
  Style can be regular, solid, light, thin or duotone
  Weight defaults to nothing (classic) but can be set to sharp
  """
  @spec icon(map) :: Phoenix.LiveView.Rendered.t()
  def icon(assigns) do
    style =
      if Application.get_env(:fontawesome, :free_only, false) do
        assigns[:style]
        |> fa_prefix()
        |> free_style()
      else
        fa_prefix(assigns[:style])
      end

    weight =
      if Application.get_env(:fontawesome, :free_only, false) do
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
    <i class={@class} style={@css}></i>
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
  @spec standard_icons() :: [String.t()]
  defdelegate standard_icons(), to: Fontawesome.StandardIcons

  @doc """
  The version of FontAwesome this was built against (for the icon lists)
  """
  @spec version() :: String.t()
  def version(), do: "6.5.1"
end
