defmodule PhoenixMysqlJsonWeb.PageController do
  use PhoenixMysqlJsonWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
