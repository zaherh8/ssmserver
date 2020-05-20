# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ssmserver,
  ecto_repos: [Ssmserver.Repo]

config :ssmserver, Ssmserver.Repo,
  username: "postgres",
  password: "postgres",
  database: "postgres",
  hostname: "localhost",
  port: 5434,
  show_sensitive_data_on_connection_error: true,
  pool_size: 100

config :ssmserver, Ssmserver.Mailer,
  adapter: Bamboo.MailgunAdapter,
  domain: "sandboxf094ee0f815c409c8412ca666f1d1ff7.mailgun.org",
  api_key: "7c320e7c565f8a44af7eb48d33cb5a2f-f135b0f1-cb7a4694",
  base_uri: "https://api.mailgun.net/v3"
# Configures the endpoint
config :ssmserver, SsmserverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7WCYleudMa5N3VPS0/4ZViMLY29pfa6CJqV+Yq1OF0/Id23cwiLoqxt2gv9QvADK",
  render_errors: [view: SsmserverWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ssmserver.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger,
  backends: [{LoggerFileBackend, :warn}],
  compile_time_purge_matching: [
              [level_lower_than: :warn]
            ]


config :logger, :warn,
  format: "$time $message\n",
  metadata: [:request_id],
  path: "./log_file.log",
  level: :warn


# config :ssmserver, Ssmserver.Mailer,
#   adapter: Bamboo.LocalAdapter
# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
