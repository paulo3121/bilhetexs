defmodule Bilhetexs.SalesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bilhetexs.Sales` context.
  """

  @doc """
  Generate a order.
  """
  def order_fixture(attrs \\ %{}) do
    {:ok, order} =
      attrs
      |> Enum.into(%{
        status: "some status",
        total_amount: 42
      })
      |> Bilhetexs.Sales.create_order()

    order
  end
end
