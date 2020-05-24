defmodule BdoApp.Repo do
  use Ecto.Repo,
    otp_app: :bdo_app,
    adapter: Ecto.Adapters.Postgres
end
