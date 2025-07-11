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

  @doc """
  Generate a order_item.
  """
  def order_item_fixture(attrs \\ %{}) do
    {:ok, order_item} =
      attrs
      |> Enum.into(%{
        price_at_purchase: 120.5,
        quantity: 42
      })
      |> Bilhetexs.Sales.create_order_item()

    order_item
  end
end
