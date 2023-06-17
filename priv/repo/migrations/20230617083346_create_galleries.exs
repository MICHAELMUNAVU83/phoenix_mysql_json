defmodule PhoenixMysqlJson.Repo.Migrations.CreateGalleries do
  use Ecto.Migration

  def change do
    create table(:galleries) do
      add(:name, :string)
      add(:photos, {:map, :string}, default: %{})

      timestamps()
    end
  end
end
