# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :easy,
  ecto_repos: [Easy.Repo]

# Configures the endpoint
config :easy, EasyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tJ0a919jxz6ItFuE1C7HzDaEW3jOG++DJ3RXtq1sD5SFvWsusI1ZCqNbc0UXycLb",
  render_errors: [view: EasyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Easy.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

## Configure Uberauth for Auth0
config :ueberauth, Ueberauth,
  providers: [
    auth0: {Ueberauth.Strategy.Auth0, []}
  ]

config :ueberauth, Ueberauth.Strategy.Auth0.OAuth,
  domain: System.get_env("AUTH0_DOMAIN"),
  client_id: System.get_env("AUTH0_CLIENT_ID"),
  client_secret: System.get_env("AUTH0_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
