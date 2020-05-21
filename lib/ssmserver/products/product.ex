defmodule Ssmserver.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:barcode, :string, []}
  @derive {Phoenix.Param, key: :barcode}
  @schema_prefix "ssm"
  schema "products" do
    field :name, :string
    field :brand, :string
    field :quantity, :integer
    field :price, :float
    field :lastscan, :string
    field :lastordered, :string
    field :whlocation, :string
    field :prlocation, {:array, :string}
    field :category, :string
    field :supplier, :string
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
      :category,
      :supplier
    ])
  end
end
