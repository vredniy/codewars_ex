defmodule CodewarsEx do
  use Application

  def start(_type, _args) do

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, CodewarsEx.Router, [],
        dispatch: dispatch(),
        port: 4000)
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: CodewarsEx.Supervisor)
  end

  defp dispatch do
    [
      {:_, [
          {"/ws", CodewarsEx.SocketHandler, []},
          {:_, Plug.Adapters.Cowboy.Handler, {CodewarsEx.Router, []}}
        ]}
    ]
  end

end
