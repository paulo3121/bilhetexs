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

  describe "order_items" do
    alias Bilhetexs.Sales.OrderItem

    import Bilhetexs.SalesFixtures

    @invalid_attrs %{quantity: nil, price_at_purchase: nil}

    test "list_order_items/0 returns all order_items" do
      order_item = order_item_fixture()
      assert Sales.list_order_items() == [order_item]
    end

    test "get_order_item!/1 returns the order_item with given id" do
      order_item = order_item_fixture()
      assert Sales.get_order_item!(order_item.id) == order_item
    end

    test "create_order_item/1 with valid data creates a order_item" do
      valid_attrs = %{quantity: 42, price_at_purchase: 120.5}

      assert {:ok, %OrderItem{} = order_item} = Sales.create_order_item(valid_attrs)
      assert order_item.quantity == 42
      assert order_item.price_at_purchase == 120.5
    end

    test "create_order_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_order_item(@invalid_attrs)
    end

    test "update_order_item/2 with valid data updates the order_item" do
      order_item = order_item_fixture()
      update_attrs = %{quantity: 43, price_at_purchase: 456.7}

      assert {:ok, %OrderItem{} = order_item} = Sales.update_order_item(order_item, update_attrs)
      assert order_item.quantity == 43
      assert order_item.price_at_purchase == 456.7
    end

    test "update_order_item/2 with invalid data returns error changeset" do
      order_item = order_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_order_item(order_item, @invalid_attrs)
      assert order_item == Sales.get_order_item!(order_item.id)
    end

    test "delete_order_item/1 deletes the order_item" do
      order_item = order_item_fixture()
      assert {:ok, %OrderItem{}} = Sales.delete_order_item(order_item)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_order_item!(order_item.id) end
    end

    test "change_order_item/1 returns a order_item changeset" do
      order_item = order_item_fixture()
      assert %Ecto.Changeset{} = Sales.change_order_item(order_item)
    end
  end
end
