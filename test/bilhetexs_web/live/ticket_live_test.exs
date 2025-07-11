defmodule BilhetexsWeb.TicketLiveTest do
  use BilhetexsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bilhetexs.TicketingFixtures

  @create_attrs %{status: "some status", uuid: "7488a646-e31f-11e4-aace-600308960662"}
  @update_attrs %{status: "some updated status", uuid: "7488a646-e31f-11e4-aace-600308960668"}
  @invalid_attrs %{status: nil, uuid: nil}

  defp create_ticket(_) do
    ticket = ticket_fixture()
    %{ticket: ticket}
  end

  describe "Index" do
    setup [:create_ticket]

    test "lists all tickets", %{conn: conn, ticket: ticket} do
      {:ok, _index_live, html} = live(conn, ~p"/tickets")

      assert html =~ "Listing Tickets"
      assert html =~ ticket.status
    end

    test "saves new ticket", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/tickets")

      assert index_live |> element("a", "New Ticket") |> render_click() =~
               "New Ticket"

      assert_patch(index_live, ~p"/tickets/new")

      assert index_live
             |> form("#ticket-form", ticket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket-form", ticket: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tickets")

      html = render(index_live)
      assert html =~ "Ticket created successfully"
      assert html =~ "some status"
    end

    test "updates ticket in listing", %{conn: conn, ticket: ticket} do
      {:ok, index_live, _html} = live(conn, ~p"/tickets")

      assert index_live |> element("#tickets-#{ticket.id} a", "Edit") |> render_click() =~
               "Edit Ticket"

      assert_patch(index_live, ~p"/tickets/#{ticket}/edit")

      assert index_live
             |> form("#ticket-form", ticket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#ticket-form", ticket: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/tickets")

      html = render(index_live)
      assert html =~ "Ticket updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes ticket in listing", %{conn: conn, ticket: ticket} do
      {:ok, index_live, _html} = live(conn, ~p"/tickets")

      assert index_live |> element("#tickets-#{ticket.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#tickets-#{ticket.id}")
    end
  end

  describe "Show" do
    setup [:create_ticket]

    test "displays ticket", %{conn: conn, ticket: ticket} do
      {:ok, _show_live, html} = live(conn, ~p"/tickets/#{ticket}")

      assert html =~ "Show Ticket"
      assert html =~ ticket.status
    end

    test "updates ticket within modal", %{conn: conn, ticket: ticket} do
      {:ok, show_live, _html} = live(conn, ~p"/tickets/#{ticket}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Ticket"

      assert_patch(show_live, ~p"/tickets/#{ticket}/show/edit")

      assert show_live
             |> form("#ticket-form", ticket: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#ticket-form", ticket: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/tickets/#{ticket}")

      html = render(show_live)
      assert html =~ "Ticket updated successfully"
      assert html =~ "some updated status"
    end
  end
end
