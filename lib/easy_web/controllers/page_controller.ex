defmodule EasyWeb.PageController do
  use EasyWeb, :controller

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    IO.puts("#####CONN######")
    IO.inspect(conn)
    IO.puts("#####CONN######")
    render(conn, "index.html", current_user: get_session(conn, :current_user))
  end
end
