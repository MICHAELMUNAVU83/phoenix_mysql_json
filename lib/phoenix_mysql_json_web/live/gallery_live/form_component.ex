defmodule PhoenixMysqlJsonWeb.GalleryLive.FormComponent do
  use PhoenixMysqlJsonWeb, :live_component

  alias PhoenixMysqlJson.Galleries

  @impl true
  def update(%{gallery: gallery} = assigns, socket) do
    changeset = Galleries.change_gallery(gallery)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"gallery" => gallery_params}, socket) do
    changeset =
      socket.assigns.gallery
      |> Galleries.change_gallery(gallery_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"gallery" => gallery_params}, socket) do
    new_gallery_params = Map.put(gallery_params, "photos", %{"1" => "1", "2" => "2"})

  
    save_gallery(socket, socket.assigns.action, new_gallery_params)
  end

  defp save_gallery(socket, :edit, gallery_params) do
    case Galleries.update_gallery(socket.assigns.gallery, gallery_params) do
      {:ok, _gallery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gallery updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_gallery(socket, :new, gallery_params) do
    case Galleries.create_gallery(gallery_params) do
      {:ok, _gallery} ->
        {:noreply,
         socket
         |> put_flash(:info, "Gallery created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
