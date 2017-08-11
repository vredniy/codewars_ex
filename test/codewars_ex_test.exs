defmodule CodewarsExTest do
  use ExUnit.Case
  doctest CodewarsEx

  test "greets the world" do
    assert CodewarsEx.hello() == :world
  end
end
