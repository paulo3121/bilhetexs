defmodule Bilhetexs.TicketingTest do
  use Bilhetexs.DataCase

  alias Bilhetexs.Ticketing

  describe "tickets" do
    alias Bilhetexs.Ticketing.Ticket

    import Bilhetexs.TicketingFixtures

    @invalid_attrs %{status: nil, uuid: nil}

    test "list_tickets/0 returns all tickets" do
      ticket = ticket_fixture()
      assert Ticketing.list_tickets() == [ticket]
    end

    test "get_ticket!/1 returns the ticket with given id" do
      ticket = ticket_fixture()
      assert Ticketing.get_ticket!(ticket.id) == ticket
    end

    test "create_ticket/1 with valid data creates a ticket" do
      valid_attrs = %{status: "some status", uuid: "7488a646-e31f-11e4-aace-600308960662"}

      assert {:ok, %Ticket{} = ticket} = Ticketing.create_ticket(valid_attrs)
      assert ticket.status == "some status"
      assert ticket.uuid == "7488a646-e31f-11e4-aace-600308960662"
    end

    test "create_ticket/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ticketing.create_ticket(@invalid_attrs)
    end

    test "update_ticket/2 with valid data updates the ticket" do
      ticket = ticket_fixture()
      update_attrs = %{status: "some updated status", uuid: "7488a646-e31f-11e4-aace-600308960668"}

      assert {:ok, %Ticket{} = ticket} = Ticketing.update_ticket(ticket, update_attrs)
      assert ticket.status == "some updated status"
      assert ticket.uuid == "7488a646-e31f-11e4-aace-600308960668"
    end

    test "update_ticket/2 with invalid data returns error changeset" do
      ticket = ticket_fixture()
      assert {:error, %Ecto.Changeset{}} = Ticketing.update_ticket(ticket, @invalid_attrs)
      assert ticket == Ticketing.get_ticket!(ticket.id)
    end

    test "delete_ticket/1 deletes the ticket" do
      ticket = ticket_fixture()
      assert {:ok, %Ticket{}} = Ticketing.delete_ticket(ticket)
      assert_raise Ecto.NoResultsError, fn -> Ticketing.get_ticket!(ticket.id) end
    end

    test "change_ticket/1 returns a ticket changeset" do
      ticket = ticket_fixture()
      assert %Ecto.Changeset{} = Ticketing.change_ticket(ticket)
    end
  end
end
