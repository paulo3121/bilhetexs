defmodule Bilhetexs.TicketingFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bilhetexs.Ticketing` context.
  """

  @doc """
  Generate a ticket.
  """
  def ticket_fixture(attrs \\ %{}) do
    {:ok, ticket} =
      attrs
      |> Enum.into(%{
        status: "some status",
        uuid: "7488a646-e31f-11e4-aace-600308960662"
      })
      |> Bilhetexs.Ticketing.create_ticket()

    ticket
  end
end
