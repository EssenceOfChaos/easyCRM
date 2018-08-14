defmodule EasyWeb.Plugs.Auth do
  import Plug.Conn
  import Phoenix.Controller

  @moduledoc """
  Defines the boundry for authentication
  """

  @spec init(any()) :: any()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def call(conn, _params) do
    user = get_session(conn, :current_user)

    case user do
      nil ->
        conn
        |> put_flash(:info, "That action is restricted to logged in users")

      _ ->
        conn |> assign(:current_user, user)
    end
  end
end
