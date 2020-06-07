# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bdo_app,
  ecto_repos: [BdoApp.Repo]

# Configures the endpoint
config :bdo_app, BdoAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JSkLtQ1TbF9c7rovbGF3b36Zsk9aFBbRTKNw+wbep3N7ghmrRwtFw6UKfcrAzn5V",
  render_errors: [view: BdoAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: BdoApp.PubSub,
  live_view: [signing_salt: "W6QsrPQ7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix, :format_encoders, json: BdoAppWeb.Encoders.CamelCase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config("#{Mix.env()}.exs")
