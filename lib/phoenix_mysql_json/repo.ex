defmodule PhoenixMysqlJson.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_mysql_json,
    adapter: Ecto.Adapters.MyXQL
end
