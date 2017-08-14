defmodule CodewarsEx.Router do
  use Plug.Router
  use Plug.Debugger, otp_app: :codewars_ex

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:json],
    json_decoder: Poison

  plug :match
  plug :dispatch

  post "/webhook" do
    {:ok, file} = File.open "./dump.json", [:append]

    IO.binwrite file, (Poison.encode!(conn.body_params) <> "\n")

    File.close file

    send_resp(conn, 200, "hello")
  end

  match _ do
    send_resp(conn, 404, "not_found")
  end
end
