defmodule BilhetexsWeb.VenueLive.Index do
  use BilhetexsWeb, :live_view

  alias Bilhetexs.Events
  alias Bilhetexs.Events.Venue

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :venues, Events.list_venues())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Venue")
    |> assign(:venue, Events.get_venue!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Venue")
    |> assign(:venue, %Venue{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Venues")
    |> assign(:venue, nil)
  end

  @impl true
  def handle_info({BilhetexsWeb.VenueLive.FormComponent, {:saved, venue}}, socket) do
    {:noreply, stream_insert(socket, :venues, venue)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    venue = Events.get_venue!(id)
    {:ok, _} = Events.delete_venue(venue)

    {:noreply, stream_delete(socket, :venues, venue)}
  end
end
