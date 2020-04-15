defmodule Ssmserver.Alerts.Alert do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ssm"
  schema "alerts" do
    field :category, :string
    field :condition, :string
    field :product, :integer
    field :quantity, :integer
    field :send, :string

    timestamps()
  end

  @doc false
  def changeset(alert, attrs) do
    alert
    |> cast(attrs, [:condition, :quantity, :product, :send, :category])
    |> validate_required([:condition, :quantity, :send])
  end
end
