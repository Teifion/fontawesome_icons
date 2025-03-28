defmodule FontawesomeTest do
  use ExUnit.Case
  require Phoenix.LiveViewTest

  test "Brand icons" do
    results = Fontawesome.brand_icons()
    assert is_list(results)
    assert not Enum.empty?(results)
    assert is_bitstring(hd(results))
  end

  test "Regular icons" do
    results = Fontawesome.regular_icons()
    assert is_list(results)
    assert not Enum.empty?(results)
    assert is_bitstring(hd(results))
  end

  test "basic test" do
    html = Phoenix.LiveViewTest.render_component(&Fontawesome.icon/1, icon: "icon1")
    assert html =~ "fa-fw fa-regular   fa-icon1"

    html =
      Phoenix.LiveViewTest.render_component(&Fontawesome.icon/1, icon: "icon2", weight: "sharp")

    assert html =~ "fa-fw fa-regular  fa-sharp fa-icon2"

    html =
      Phoenix.LiveViewTest.render_component(&Fontawesome.icon/1, icon: "icon3", style: "solid")

    assert html =~ "fa-fw fa-solid   fa-icon3"

    html =
      Phoenix.LiveViewTest.render_component(&Fontawesome.icon/1,
        icon: "icon4",
        style: "solid",
        weight: "sharp"
      )

    assert html =~ "fa-fw fa-solid  fa-sharp fa-icon4"
  end

  test "limited to free only" do
    Application.put_env(:fontawesome_icons, :free_only, true)

    html = Phoenix.LiveViewTest.render_component(&Fontawesome.icon/1, icon: "icon1")
    assert html =~ "fa-fw fa-solid   fa-icon1"

    html =
      Phoenix.LiveViewTest.render_component(&Fontawesome.icon/1, icon: "icon2", weight: "sharp")

    assert html =~ "fa-fw fa-solid   fa-icon2"

    Application.put_env(:fontawesome_icons, :free_only, false)
  end
end
