defmodule Bilhetexs.EventsTest do
  use Bilhetexs.DataCase

  alias Bilhetexs.Events

  describe "venues" do
    alias Bilhetexs.Events.Venue

    import Bilhetexs.EventsFixtures

    @invalid_attrs %{name: nil, address: nil, capacity: nil}

    test "list_venues/0 returns all venues" do
      venue = venue_fixture()
      assert Events.list_venues() == [venue]
    end

    test "get_venue!/1 returns the venue with given id" do
      venue = venue_fixture()
      assert Events.get_venue!(venue.id) == venue
    end

    test "create_venue/1 with valid data creates a venue" do
      valid_attrs = %{name: "some name", address: "some address", capacity: 42}

      assert {:ok, %Venue{} = venue} = Events.create_venue(valid_attrs)
      assert venue.name == "some name"
      assert venue.address == "some address"
      assert venue.capacity == 42
    end

    test "create_venue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_venue(@invalid_attrs)
    end

    test "update_venue/2 with valid data updates the venue" do
      venue = venue_fixture()
      update_attrs = %{name: "some updated name", address: "some updated address", capacity: 43}

      assert {:ok, %Venue{} = venue} = Events.update_venue(venue, update_attrs)
      assert venue.name == "some updated name"
      assert venue.address == "some updated address"
      assert venue.capacity == 43
    end

    test "update_venue/2 with invalid data returns error changeset" do
      venue = venue_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_venue(venue, @invalid_attrs)
      assert venue == Events.get_venue!(venue.id)
    end

    test "delete_venue/1 deletes the venue" do
      venue = venue_fixture()
      assert {:ok, %Venue{}} = Events.delete_venue(venue)
      assert_raise Ecto.NoResultsError, fn -> Events.get_venue!(venue.id) end
    end

    test "change_venue/1 returns a venue changeset" do
      venue = venue_fixture()
      assert %Ecto.Changeset{} = Events.change_venue(venue)
    end
  end

  describe "events" do
    alias Bilhetexs.Events.Event

    import Bilhetexs.EventsFixtures

    @invalid_attrs %{name: nil, status: nil, date: nil, description: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{name: "some name", status: "some status", date: ~U[2025-07-09 22:59:00Z], description: "some description"}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.name == "some name"
      assert event.status == "some status"
      assert event.date == ~U[2025-07-09 22:59:00Z]
      assert event.description == "some description"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{name: "some updated name", status: "some updated status", date: ~U[2025-07-10 22:59:00Z], description: "some updated description"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.name == "some updated name"
      assert event.status == "some updated status"
      assert event.date == ~U[2025-07-10 22:59:00Z]
      assert event.description == "some updated description"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "ticket_types" do
    alias Bilhetexs.Events.TicketType

    import Bilhetexs.EventsFixtures

    @invalid_attrs %{name: nil, price: nil, total_quantity: nil, sold_quantity: nil}

    test "list_ticket_types/0 returns all ticket_types" do
      ticket_type = ticket_type_fixture()
      assert Events.list_ticket_types() == [ticket_type]
    end

    test "get_ticket_type!/1 returns the ticket_type with given id" do
      ticket_type = ticket_type_fixture()
      assert Events.get_ticket_type!(ticket_type.id) == ticket_type
    end

    test "create_ticket_type/1 with valid data creates a ticket_type" do
      valid_attrs = %{name: "some name", price: 120.5, total_quantity: 42, sold_quantity: 42}

      assert {:ok, %TicketType{} = ticket_type} = Events.create_ticket_type(valid_attrs)
      assert ticket_type.name == "some name"
      assert ticket_type.price == 120.5
      assert ticket_type.total_quantity == 42
      assert ticket_type.sold_quantity == 42
    end

    test "create_ticket_type/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_ticket_type(@invalid_attrs)
    end

    test "update_ticket_type/2 with valid data updates the ticket_type" do
      ticket_type = ticket_type_fixture()
      update_attrs = %{name: "some updated name", price: 456.7, total_quantity: 43, sold_quantity: 43}

      assert {:ok, %TicketType{} = ticket_type} = Events.update_ticket_type(ticket_type, update_attrs)
      assert ticket_type.name == "some updated name"
      assert ticket_type.price == 456.7
      assert ticket_type.total_quantity == 43
      assert ticket_type.sold_quantity == 43
    end

    test "update_ticket_type/2 with invalid data returns error changeset" do
      ticket_type = ticket_type_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_ticket_type(ticket_type, @invalid_attrs)
      assert ticket_type == Events.get_ticket_type!(ticket_type.id)
    end

    test "delete_ticket_type/1 deletes the ticket_type" do
      ticket_type = ticket_type_fixture()
      assert {:ok, %TicketType{}} = Events.delete_ticket_type(ticket_type)
      assert_raise Ecto.NoResultsError, fn -> Events.get_ticket_type!(ticket_type.id) end
    end

    test "change_ticket_type/1 returns a ticket_type changeset" do
      ticket_type = ticket_type_fixture()
      assert %Ecto.Changeset{} = Events.change_ticket_type(ticket_type)
    end
  end
end
