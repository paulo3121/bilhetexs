defmodule Bilhetexs.Sales.OrderItem do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "order_items" do
    field :quantity, :integer
    field :price_at_purchase, :float
    field :order_id, :binary_id
    field :ticket_type_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order_item, attrs) do
    order_item
    |> cast(attrs, [:quantity, :price_at_purchase])
    |> validate_required([:quantity, :price_at_purchase])
  end
end
