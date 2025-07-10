defmodule Bilhetexs.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bilhetexs.Events` context.
  """

  @doc """
  Generate a venue.
  """
  def venue_fixture(attrs \\ %{}) do
    {:ok, venue} =
      attrs
      |> Enum.into(%{
        address: "some address",
        capacity: 42,
        name: "some name"
      })
      |> Bilhetexs.Events.create_venue()

    venue
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        date: ~U[2025-07-09 22:59:00Z],
        description: "some description",
        name: "some name",
        status: "some status"
      })
      |> Bilhetexs.Events.create_event()

    event
  end
end
