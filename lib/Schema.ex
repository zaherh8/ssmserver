defmodule SsmserverWeb.Schema do
  use Absinthe.Schema
  alias SsmserverWeb.UserResolver
  import_types(SsmserverWeb.Types)
  query do
    @desc "return all users"
    field :user, type: list_of(:user) do
      resolve(&UserResolver.get_users/2)
    end
  end
  mutation do
    @desc "create a user"
    field :createuser, type: :user do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      arg(:position, :string)
      arg(:role, :string)
      resolve(&UserResolver.create_user/2)
    end
  end
end
