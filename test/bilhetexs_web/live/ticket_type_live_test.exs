defmodule BilhetexsWeb.TicketTypeLiveTest do
  use BilhetexsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bilhetexs.EventsFixtures

  @create_attrs %{name: "some name", price: 120.5, total_quantity: 42, sold_quantity: 42}
  @update_attrs %{name: "some updated name", price: 456.7, total_quantity: 43, sold_quantity: 43}
  @invalid_attrs %{name: nil, price: nil, total_quantity: nil, sold_quantity: nil}

  defp create_ticket_type(_) do
    ticket_type = ticket_type_fixture()
    %{ticket_type: ticket_type}
  end

  describe "Index" do
    setup [:create_ticket_type]

    test "lists all ticket_types", %{conn: conn, ticket_type: ticket_type} do
      {:ok, _index_live, html} = live(conn, ~p"/ticket_types")

      assert html =~ "Listing Ticket types"
      assert html =~ ticket_type.name
    end

    test "saves new ticket_type", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_types")

      assert index_live |> element("a", "New Ticket type") |> render_click() =~
               "New Ticket type"

      assert_patch(index_live, ~p"/ticket_types/new")

      assert index_live
             |> form("#ticket_type-form", ticket_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket_type-form", ticket_type: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ticket_types")

      html = render(index_live)
      assert html =~ "Ticket type created successfully"
      assert html =~ "some name"
    end

    test "updates ticket_type in listing", %{conn: conn, ticket_type: ticket_type} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_types")

      assert index_live |> element("#ticket_types-#{ticket_type.id} a", "Edit") |> render_click() =~
               "Edit Ticket type"

      assert_patch(index_live, ~p"/ticket_types/#{ticket_type}/edit")

      assert index_live
             |> form("#ticket_type-form", ticket_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket_type-form", ticket_type: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/ticket_types")

      html = render(index_live)
      assert html =~ "Ticket type updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes ticket_type in listing", %{conn: conn, ticket_type: ticket_type} do
      {:ok, index_live, _html} = live(conn, ~p"/ticket_types")

      assert index_live |> element("#ticket_types-#{ticket_type.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#ticket_types-#{ticket_type.id}")
    end
  end

  describe "Show" do
    setup [:create_ticket_type]

    test "displays ticket_type", %{conn: conn, ticket_type: ticket_type} do
      {:ok, _show_live, html} = live(conn, ~p"/ticket_types/#{ticket_type}")

      assert html =~ "Show Ticket type"
      assert html =~ ticket_type.name
    end

    test "updates ticket_type within modal", %{conn: conn, ticket_type: ticket_type} do
      {:ok, show_live, _html} = live(conn, ~p"/ticket_types/#{ticket_type}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ticket type"

      assert_patch(show_live, ~p"/ticket_types/#{ticket_type}/show/edit")

      assert show_live
             |> form("#ticket_type-form", ticket_type: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ticket_type-form", ticket_type: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/ticket_types/#{ticket_type}")

      html = render(show_live)
      assert html =~ "Ticket type updated successfully"
      assert html =~ "some updated name"
    end
  end
end
