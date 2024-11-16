defmodule PhoenixNest.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_nest,
    adapter: Ecto.Adapters.Postgres
end
