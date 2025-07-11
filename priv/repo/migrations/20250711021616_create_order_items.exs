defmodule Bilhetexs.Repo.Migrations.CreateOrderItems do
  use Ecto.Migration

  def change do
    create table(:order_items, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :quantity, :integer
      add :price_at_purchase, :float
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)
      add :ticket_type_id, references(:ticket_types, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:order_items, [:order_id])
    create index(:order_items, [:ticket_type_id])
  end
end
