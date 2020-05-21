defmodule SsmserverWeb.FileController do
  use SsmserverWeb, :controller

  def index(conn, _params) do
    send_file(conn, conn)
  end
  @spec send_file(Plug.Conn.t(), any) :: Plug.Conn.t()
  def send_file(conn, _params) do
    IO.inspect("############3")
    conn =
      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", ~s[attachment; filename="log.log"])
      |> send_chunked(:ok)

    File.stream!("./log_file.log", [:read_ahead], :line)
    |>Stream.each(fn line->
      conn
        |> chunk(line) end)
    |>Stream.run()
    conn
  end
end
