defmodule SsmserverWeb.Types do
  @moduledoc """
  This module is responsible for defining the types of objcts to be used in graphql schemas
  """
  use Absinthe.Schema.Notation

  object :user do
    field(:username, :string)
    field(:role, :string)
    field(:password,:string)
    field(:position, :string)
  end
end
