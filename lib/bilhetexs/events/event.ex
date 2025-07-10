defmodule Bilhetexs.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "events" do
    field :name, :string
    field :status, :string
    field :date, :utc_datetime
    field :description, :string
    field :venue_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :description, :date, :status])
    |> validate_required([:name, :description, :date, :status])
  end
end
