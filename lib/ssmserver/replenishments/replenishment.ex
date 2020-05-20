defmodule Ssmserver.Replenishments.Replenishment do
  use Ecto.Schema
  import Ecto.Changeset
  @schema_prefix "ssm"
  schema "replenishment" do
    field :active, :boolean, default: false
    field :condition, :string
    field :email, :string
    field :product, :string
    field :quantity, :integer
    field :quantitytoorder, :integer
    timestamps()
  end

  @doc false
  def changeset(replenishment, attrs) do
    replenishment
    |> cast(attrs, [:email, :active, :condition, :product, :quantity, :quantitytoorder])
    |> validate_required([:email, :active, :condition, :product, :quantity, :quantitytoorder])
  end
end
