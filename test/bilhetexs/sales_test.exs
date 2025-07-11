defmodule Bilhetexs.SalesTest do
  use Bilhetexs.DataCase

  alias Bilhetexs.Sales

  describe "orders" do
    alias Bilhetexs.Sales.Order

    import Bilhetexs.SalesFixtures

    @invalid_attrs %{status: nil, total_amount: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Sales.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Sales.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{status: "some status", total_amount: 42}

      assert {:ok, %Order{} = order} = Sales.create_order(valid_attrs)
      assert order.status == "some status"
      assert order.total_amount == 42
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{status: "some updated status", total_amount: 43}

      assert {:ok, %Order{} = order} = Sales.update_order(order, update_attrs)
      assert order.status == "some updated status"
      assert order.total_amount == 43
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_order(order, @invalid_attrs)
      assert order == Sales.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Sales.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Sales.change_order(order)
    end
  end
end
