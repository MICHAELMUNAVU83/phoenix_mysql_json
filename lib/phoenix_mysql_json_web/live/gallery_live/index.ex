defmodule PhoenixMysqlJsonWeb.GalleryLive.Index do
  use PhoenixMysqlJsonWeb, :live_view

  alias PhoenixMysqlJson.Galleries
  alias PhoenixMysqlJson.Galleries.Gallery

  @impl true
  def mount(_params, _session, socket) do
    array_list = ["1", "2"]

    #  create a map from the array

    map_list = Enum.map(array_list, fn x -> {x, x} end) |> Map.new()
    IO.inspect(map_list)

    {:ok, assign(socket, :galleries, list_galleries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Gallery")
    |> assign(:gallery, Galleries.get_gallery!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Gallery")
    |> assign(:gallery, %Gallery{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Galleries")
    |> assign(:gallery, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    gallery = Galleries.get_gallery!(id)
    {:ok, _} = Galleries.delete_gallery(gallery)

    {:noreply, assign(socket, :galleries, list_galleries())}
  end

  defp list_galleries do
    Galleries.list_galleries()
  end
end
