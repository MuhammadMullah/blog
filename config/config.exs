# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  server: true,
  secret_key_base: "9hY1TYpcXmf/RD0VpkoOe8V7f8dslKsb/QVDJzVnE/R6jPkTCbLXfgdBAr10YHdb",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blog.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason


# docker mix generated image
config :mix_docker, image: "johninvictus/blog"

config :blog, Blog.Guardian,
  issuer: "blog",
  ttl: {30, :days},
  secret_key: "LG17BzmhBeq81Yyyn6vH7GVdrCkQpLktol2vdXlBzkRRHpYsZwluKMG9r6fnu90m"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
