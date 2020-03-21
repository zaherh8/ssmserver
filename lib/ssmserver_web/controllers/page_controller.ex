defmodule SsmserverWeb.PageController do
  use SsmserverWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
