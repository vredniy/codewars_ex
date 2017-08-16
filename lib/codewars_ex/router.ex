defmodule CodewarsEx.Router do
  use Plug.Router
  use Plug.Debugger #, otp_app: :codewars_ex

  use WebSocket

  socket "/echo",  CodewarsEx.EchoController,  :echo

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json],
    json_decoder: Poison

  plug Plug.Static, at: "/", from: :web_socket

  plug :match
  plug :dispatch

  get "/" do
    data = "priv/static/index.html"
    |> Path.expand
    |> File.read!
    conn |> send_resp(200, data)
  end

  post "/webhook" do
    {:ok, file} = File.open "./dump.json", [:append]

    IO.binwrite file, (Poison.encode!(conn.body_params) <> "\n")

    WebSocket.Events.broadcast!(:echo, {:text, Poison.encode!(conn.body_params)})

    File.close file

    send_resp(conn, 200, "hello")
  end

  match _ do
    send_resp(conn, 404, "not_found")
  end
end
