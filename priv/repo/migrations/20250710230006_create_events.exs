defmodule Bilhetexs.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :text
      add :date, :utc_datetime
      add :status, :string
      add :venue_id, references(:venues, on_delete: :nothing, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:venue_id])
  end
end
