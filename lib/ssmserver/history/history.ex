defmodule Ssmserver.Histories.History do
  use Ecto.Schema
  import Ecto.Changeset

  @schema_prefix "ssm"
  schema "history" do
    field :product, :string
    field :date, :string
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(history, attrs) do
    history
    |> cast(attrs, [:product, :date, :quantity])
    |> validate_required([:product, :date, :quantity])
  end
end
