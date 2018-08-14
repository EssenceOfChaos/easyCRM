defmodule EasyWeb.Router do
  use EasyWeb, :router
  alias EasyWeb.Plugs.Auth

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(Auth)
    plug(:put_user_token)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  ## AUTH ROUTES
  scope "/auth", EasyWeb do
    pipe_through(:browser)
    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
    post("/:provider/callback", AuthController, :callback)
  end

  scope "/", EasyWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    resources("/employees", EmployeeController)
    get("/logout", AuthController, :logout)
  end

  # Other scopes may use custom stacks.
  # scope "/api", EasyWeb do
  #   pipe_through :api
  # end
  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end
end
