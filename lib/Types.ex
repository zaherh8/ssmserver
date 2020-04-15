defmodule SsmserverWeb.Types do
  @moduledoc """
  This module is responsible for defining the types of objcts to be used in graphql schemas
  """
  use Absinthe.Schema.Notation

  object :user do
    field(:username, :string)
    field(:role, :string)
    field(:password, :string)
    field(:position, :string)
    field(:email, :string)
    field(:id, :integer)
  end

  object :product do
    field(:name, :string)
    field(:brand, :string)
    field(:quantity, :integer)
    field(:price, :float)
    field(:whlocation, :string)
    field(:prlocation, :string)
    field(:lastordered, :string)
    field(:lastscanned, :string)
    field(:barcode, :string)
    field(:category, :string)
    field(:id, :integer)
  end

  object :alert do
    field(:id, :integer)
    field(:product, :integer)
    field(:quantity, :integer)
    field(:send, :string)
    field(:category, :string)
    field(:condition, :string)
  end

  object :replenishment do
    field(:id, :integer)
    field(:product, :integer)
    field(:quantity, :integer)
    field(:quantitytoorder, :integer)
    field(:email, :string)
    field(:condition, :string)
    field(:active, :boolean)
  end
end
