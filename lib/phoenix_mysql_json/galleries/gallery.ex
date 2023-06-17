defmodule PhoenixMysqlJson.Galleries.Gallery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "galleries" do
    field :name, :string
    field :photos, {:map, :string}, default: %{}

    timestamps()
  end

  @doc false
  def changeset(gallery, attrs) do
    gallery
    |> cast(attrs, [:name, :photos])
    |> validate_required([:name, :photos])
  end
end
