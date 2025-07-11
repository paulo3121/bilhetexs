defmodule BilhetexsWeb.TicketTypeLive.FormComponent do
  use BilhetexsWeb, :live_component

  alias Bilhetexs.Events

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage ticket_type records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="ticket_type-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:total_quantity]} type="number" label="Total quantity" />
        <.input field={@form[:sold_quantity]} type="number" label="Sold quantity" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Ticket type</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{ticket_type: ticket_type} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Events.change_ticket_type(ticket_type))
     end)}
  end

  @impl true
  def handle_event("validate", %{"ticket_type" => ticket_type_params}, socket) do
    changeset = Events.change_ticket_type(socket.assigns.ticket_type, ticket_type_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"ticket_type" => ticket_type_params}, socket) do
    save_ticket_type(socket, socket.assigns.action, ticket_type_params)
  end

  defp save_ticket_type(socket, :edit, ticket_type_params) do
    case Events.update_ticket_type(socket.assigns.ticket_type, ticket_type_params) do
      {:ok, ticket_type} ->
        notify_parent({:saved, ticket_type})

        {:noreply,
         socket
         |> put_flash(:info, "Ticket type updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_ticket_type(socket, :new, ticket_type_params) do
    case Events.create_ticket_type(ticket_type_params) do
      {:ok, ticket_type} ->
        notify_parent({:saved, ticket_type})

        {:noreply,
         socket
         |> put_flash(:info, "Ticket type created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
