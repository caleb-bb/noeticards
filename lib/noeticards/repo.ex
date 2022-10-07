defmodule Noeticards.Repo do
  use Ecto.Repo,
    otp_app: :noeticards,
    adapter: Ecto.Adapters.Postgres
end
