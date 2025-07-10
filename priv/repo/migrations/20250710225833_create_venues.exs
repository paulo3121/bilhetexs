defmodule Bilhetexs.Repo.Migrations.CreateVenues do
  use Ecto.Migration

  def change do
    create table(:venues, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :address, :string
      add :capacity, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
