defmodule NoeticardsWeb.PageController do
  use NoeticardsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
