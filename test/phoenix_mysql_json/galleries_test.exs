defmodule PhoenixMysqlJson.GalleriesTest do
  use PhoenixMysqlJson.DataCase

  alias PhoenixMysqlJson.Galleries

  describe "galleries" do
    alias PhoenixMysqlJson.Galleries.Gallery

    import PhoenixMysqlJson.GalleriesFixtures

    @invalid_attrs %{name: nil}

    test "list_galleries/0 returns all galleries" do
      gallery = gallery_fixture()
      assert Galleries.list_galleries() == [gallery]
    end

    test "get_gallery!/1 returns the gallery with given id" do
      gallery = gallery_fixture()
      assert Galleries.get_gallery!(gallery.id) == gallery
    end

    test "create_gallery/1 with valid data creates a gallery" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Gallery{} = gallery} = Galleries.create_gallery(valid_attrs)
      assert gallery.name == "some name"
    end

    test "create_gallery/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Galleries.create_gallery(@invalid_attrs)
    end

    test "update_gallery/2 with valid data updates the gallery" do
      gallery = gallery_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Gallery{} = gallery} = Galleries.update_gallery(gallery, update_attrs)
      assert gallery.name == "some updated name"
    end

    test "update_gallery/2 with invalid data returns error changeset" do
      gallery = gallery_fixture()
      assert {:error, %Ecto.Changeset{}} = Galleries.update_gallery(gallery, @invalid_attrs)
      assert gallery == Galleries.get_gallery!(gallery.id)
    end

    test "delete_gallery/1 deletes the gallery" do
      gallery = gallery_fixture()
      assert {:ok, %Gallery{}} = Galleries.delete_gallery(gallery)
      assert_raise Ecto.NoResultsError, fn -> Galleries.get_gallery!(gallery.id) end
    end

    test "change_gallery/1 returns a gallery changeset" do
      gallery = gallery_fixture()
      assert %Ecto.Changeset{} = Galleries.change_gallery(gallery)
    end
  end
end
