defmodule Ssmserver.Repo do
  use Ecto.Repo,
    otp_app: :ssmserver,
    adapter: Ecto.Adapters.Postgres
end
