defmodule Ssmserver.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  @schema_prefix "ssm"
  schema "products" do
    field :name, :string
    field :brand, :string
    field :quantity, :integer
    field :price, :float
    field :lastscan, :string
    field :lastordered, :string
    field :whlocation, :string
    field :prlocation, :string
    field :barcode, :string
    field :category, :string
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :brand,
      :prlocation,
      :whlocation,
      :barcode,
      :price,
      :quantity,
      :lastscan,
      :lastordered,
      :category
    ])
    |> validate_required([:barcode])
  end
end
