defmodule Bilhetexs.Repo.Migrations.CreateTickets do
  use Ecto.Migration

  def change do
    create table(:tickets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :uuid, :uuid
      add :status, :string
      add :order_id, references(:orders, on_delete: :nothing, type: :binary_id)
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:tickets, [:order_id])
    create index(:tickets, [:user_id])
  end
end
