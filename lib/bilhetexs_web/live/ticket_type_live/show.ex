defmodule BilhetexsWeb.TicketTypeLive.Show do
  use BilhetexsWeb, :live_view

  alias Bilhetexs.Events

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:ticket_type, Events.get_ticket_type!(id))}
  end

  defp page_title(:show), do: "Show Ticket type"
  defp page_title(:edit), do: "Edit Ticket type"
end
