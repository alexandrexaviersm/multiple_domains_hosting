defmodule Store.Repo do
  use Ecto.Repo,
    otp_app: :multiple_domains_hosting,
    adapter: Ecto.Adapters.Postgres
end
