defmodule Bilhetexs.Repo.Migrations.CreateTicketTypes do
  use Ecto.Migration

  def change do
    create table(:ticket_types, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :price, :float
      add :total_quantity, :integer
      add :sold_quantity, :integer
      add :event_id, references(:events, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:ticket_types, [:event_id])
  end
end
