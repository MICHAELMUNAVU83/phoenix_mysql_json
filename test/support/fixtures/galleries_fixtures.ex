defmodule PhoenixMysqlJson.GalleriesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixMysqlJson.Galleries` context.
  """

  @doc """
  Generate a gallery.
  """
  def gallery_fixture(attrs \\ %{}) do
    {:ok, gallery} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> PhoenixMysqlJson.Galleries.create_gallery()

    gallery
  end
end
