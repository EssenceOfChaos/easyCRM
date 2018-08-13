defmodule EasyWeb.Helpers.SetUser do
  import Plug.Conn

  @moduledoc """
  Helper functions for the view
  """
  def current_user(conn) do
    user = Plug.Conn.get_session(conn, :current_user)
  end

  def logged_in?(conn), do: !!current_user(conn)
end
