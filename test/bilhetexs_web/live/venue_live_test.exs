defmodule BilhetexsWeb.VenueLiveTest do
  use BilhetexsWeb.ConnCase

  import Phoenix.LiveViewTest
  import Bilhetexs.EventsFixtures

  @create_attrs %{name: "some name", address: "some address", capacity: 42}
  @update_attrs %{name: "some updated name", address: "some updated address", capacity: 43}
  @invalid_attrs %{name: nil, address: nil, capacity: nil}

  defp create_venue(_) do
    venue = venue_fixture()
    %{venue: venue}
  end

  describe "Index" do
    setup [:create_venue]

    test "lists all venues", %{conn: conn, venue: venue} do
      {:ok, _index_live, html} = live(conn, ~p"/venues")

      assert html =~ "Listing Venues"
      assert html =~ venue.name
    end

    test "saves new venue", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/venues")

      assert index_live |> element("a", "New Venue") |> render_click() =~
               "New Venue"

      assert_patch(index_live, ~p"/venues/new")

      assert index_live
             |> form("#venue-form", venue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#venue-form", venue: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/venues")

      html = render(index_live)
      assert html =~ "Venue created successfully"
      assert html =~ "some name"
    end

    test "updates venue in listing", %{conn: conn, venue: venue} do
      {:ok, index_live, _html} = live(conn, ~p"/venues")

      assert index_live |> element("#venues-#{venue.id} a", "Edit") |> render_click() =~
               "Edit Venue"

      assert_patch(index_live, ~p"/venues/#{venue}/edit")

      assert index_live
             |> form("#venue-form", venue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#venue-form", venue: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/venues")

      html = render(index_live)
      assert html =~ "Venue updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes venue in listing", %{conn: conn, venue: venue} do
      {:ok, index_live, _html} = live(conn, ~p"/venues")

      assert index_live |> element("#venues-#{venue.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#venues-#{venue.id}")
    end
  end

  describe "Show" do
    setup [:create_venue]

    test "displays venue", %{conn: conn, venue: venue} do
      {:ok, _show_live, html} = live(conn, ~p"/venues/#{venue}")

      assert html =~ "Show Venue"
      assert html =~ venue.name
    end

    test "updates venue within modal", %{conn: conn, venue: venue} do
      {:ok, show_live, _html} = live(conn, ~p"/venues/#{venue}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Venue"

      assert_patch(show_live, ~p"/venues/#{venue}/show/edit")

      assert show_live
             |> form("#venue-form", venue: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#venue-form", venue: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/venues/#{venue}")

      html = render(show_live)
      assert html =~ "Venue updated successfully"
      assert html =~ "some updated name"
    end
  end
end
