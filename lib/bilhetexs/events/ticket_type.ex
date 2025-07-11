defmodule Bilhetexs.Events.TicketType do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "ticket_types" do
    field :name, :string
    field :price, :float
    field :total_quantity, :integer
    field :sold_quantity, :integer
    field :event_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket_type, attrs) do
    ticket_type
    |> cast(attrs, [:name, :price, :total_quantity, :sold_quantity])
    |> validate_required([:name, :price, :total_quantity, :sold_quantity])
  end
end
