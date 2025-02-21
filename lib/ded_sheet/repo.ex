defmodule DedSheet.Repo do
  use Ecto.Repo,
    otp_app: :ded_sheet,
    adapter: Ecto.Adapters.Postgres
end
