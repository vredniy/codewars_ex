defmodule CodewarsEx do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, CodewarsEx.Router, [],
        dispatch: CodewarsEx.Router.dispatch_table(),
        port: 5000)
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CodewarsEx.Supervisor)
  end
end
