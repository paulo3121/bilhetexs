defmodule Bilhetexs.Ticketing.Ticket do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tickets" do
    field :status, :string
    field :uuid, Ecto.UUID
    field :order_id, :binary_id
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(ticket, attrs) do
    ticket
    |> cast(attrs, [:uuid, :status])
    |> validate_required([:uuid, :status])
  end
end
