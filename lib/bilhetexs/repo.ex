defmodule Bilhetexs.Repo do
  use Ecto.Repo,
    otp_app: :bilhetexs,
    adapter: Ecto.Adapters.Postgres
end
