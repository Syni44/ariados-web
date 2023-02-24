defmodule Ariados.Repo do
  use Ecto.Repo,
    otp_app: :ariados,
    adapter: Ecto.Adapters.Postgres
end
