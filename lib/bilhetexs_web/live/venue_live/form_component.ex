defmodule BilhetexsWeb.VenueLive.FormComponent do
  use BilhetexsWeb, :live_component

  alias Bilhetexs.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage venue records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="venue-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:capacity]} type="number" label="Capacity" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Venue</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{venue: venue} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_venue(venue))
     end)}
  end

  @impl true
  def handle_event("validate", %{"venue" => venue_params}, socket) do
    changeset = Events.change_venue(socket.assigns.venue, venue_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"venue" => venue_params}, socket) do
    save_venue(socket, socket.assigns.action, venue_params)
  end

  defp save_venue(socket, :edit, venue_params) do
    case Events.update_venue(socket.assigns.venue, venue_params) do
      {:ok, venue} ->
        notify_parent({:saved, venue})

        {:noreply,
         socket
         |> put_flash(:info, "Venue updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_venue(socket, :new, venue_params) do
    case Events.create_venue(venue_params) do
      {:ok, venue} ->
        notify_parent({:saved, venue})

        {:noreply,
         socket
         |> put_flash(:info, "Venue created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
