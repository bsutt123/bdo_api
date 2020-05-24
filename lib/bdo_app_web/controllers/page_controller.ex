defmodule BdoAppWeb.PageController do
  use BdoAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
