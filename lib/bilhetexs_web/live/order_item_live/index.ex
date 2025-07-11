defmodule BilhetexsWeb.OrderItemLive.Index do
  use BilhetexsWeb, :live_view

  alias Bilhetexs.Sales
  alias Bilhetexs.Sales.OrderItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :order_items, Sales.list_order_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Order item")
    |> assign(:order_item, Sales.get_order_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Order item")
    |> assign(:order_item, %OrderItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Order items")
    |> assign(:order_item, nil)
  end

  @impl true
  def handle_info({BilhetexsWeb.OrderItemLive.FormComponent, {:saved, order_item}}, socket) do
    {:noreply, stream_insert(socket, :order_items, order_item)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    order_item = Sales.get_order_item!(id)
    {:ok, _} = Sales.delete_order_item(order_item)

    {:noreply, stream_delete(socket, :order_items, order_item)}
  end
end
