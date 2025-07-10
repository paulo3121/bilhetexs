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
end
