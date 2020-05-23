defmodule SsmserverWeb.Types do
  @moduledoc """
  This module is responsible for defining the types of objcts to be used in graphql schemas
  """
  use Absinthe.Schema.Notation

  input_object :inputproduct do
    field(:barcode, :string)
    field(:quantity, :integer)
    field(:name, :string)
    field(:prlocation,  list_of(:string))
  end

  object :user do
    field(:username, :string)
    field(:role, :string)
    field(:password, :string)
    field(:position, :string)
    field(:email, :string)
    field(:id, :integer)
  end

  object :message do
    field(:text, :string)
  end

  object :product do
    field(:name, :string)
    field(:brand, :string)
    field(:quantity, :integer)
    field(:price, :float)
    field(:whlocation, :string)
    field(:prlocation,  list_of(:string))
    field(:lastordered, :string)
    field(:lastscanned, :string)
    field(:barcode, :string)
    field(:category, :string)
    field(:supplier, :string)
  end

  object :alert do
    field(:id, :integer)
    field(:product, :integer)
    field(:quantity, :integer)
    field(:send, :string)
    field(:category, :string)
    field(:condition, :string)
  end

  object :total do
    field(:total, :integer)
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
