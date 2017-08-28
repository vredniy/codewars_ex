defmodule CodewarsEx do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, CodewarsEx.Router, [],
        dispatch: CodewarsEx.Router.dispatch_table(),
        port: port(System.get_env("PORT")))
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CodewarsEx.Supervisor)
  end

  def port(nil), do: 5000
  def port(value) do
    String.to_integer(value)
  end
end
