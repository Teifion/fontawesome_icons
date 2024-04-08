# Description
A library to add a [Fontawesome](https://fontawesome.com/) component.

Note: The library says it addresses a specific version of Fontawesome but this is just for the icon lists. The library will work for all versions as it does not check the icon actually exists.

## Installation
```elixir
def deps do
  [
    {:fontawesome_icons, "~> 0.0.6"}
  ]
end
```

## Basic usage
```html
<Fontawesome.icon icon="arrow-left" />

<Fontawesome.icon icon="icon2" style="solid" />

<Fontawesome.icon icon="another-icon" weight="sharp" />

<Fontawesome.icon icon="everything" style="thin" weight="sharp" size="2x" class="my-css-class" css="border: 1px solid red;" />
```

