defmodule PhoenixMysqlJsonWeb.GalleryLive.FormComponent do
  use PhoenixMysqlJsonWeb, :live_component

  alias PhoenixMysqlJson.Galleries

  @impl true
  def update(%{gallery: gallery} = assigns, socket) do
    changeset = Galleries.change_gallery(gallery)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:uploaded_files, [])
     |> allow_upload(:images, accept: ~w(.jpg .png .jpeg), max_entries: 3)}
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
    uploaded_files =
      consume_uploaded_entries(socket, :images, fn %{path: path}, _entry ->
        dest =
          Path.join([
            :code.priv_dir(:phoenix_mysql_json),
            "static",
            "uploads",
            Path.basename(path)
          ])

        # The `static/uploads` directory must exist for `File.cp!/2`
        # and MyAppWeb.static_paths/0 should contain uploads to work,.
        File.cp!(path, dest)
        {:ok, "/uploads/" <> Path.basename(dest)}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}

    photos_map = Enum.map(uploaded_files, fn x -> {x, x} end) |> Map.new()

    new_gallery_params = Map.put(gallery_params, "photos", photos_map)

    save_gallery(socket, socket.assigns.action, new_gallery_params)
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :images, ref)}
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
