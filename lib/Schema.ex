defmodule SsmserverWeb.Schema do
  use Absinthe.Schema
  alias SsmserverWeb.AlertResolver
  alias SsmserverWeb.UserResolver
  alias SsmserverWeb.ProductResolver
  alias SsmserverWeb.ReplenishmentResolver
  import_types(SsmserverWeb.Types)

  query do
    @desc "return all products"
    field :products, type: list_of(:product) do
      resolve(&ProductResolver.get_products/2)
    end
    @desc "return all alerts"
    field :alerts, type: list_of(:alert) do
      resolve(&AlertResolver.get_alerts/2)
    end

    @desc "return all alerts"
    field :replenishments, type: list_of(:replenishment) do
      resolve(&ReplenishmentResolver.get_replenishments/2)
    end

    @desc "return a product"
    field :getproduct, type: :product do
      arg(:id, non_null(:integer))
      resolve(&ProductResolver.get_product/2)
    end

    @desc "return a product"
    field :getproductbybarcode, type: :product do
      arg(:barcode, non_null(:string))
      resolve(&ProductResolver.get_product_by_barcode/2)
    end

    @desc "return all users"
    field :user, type: list_of(:user) do
      resolve(&UserResolver.get_users/2)
    end

    @desc "return a user"
    field :getuser, type: :user do
      arg(:id, non_null(:integer))
      resolve(&UserResolver.get_user/2)
    end

    @desc "return a user"
    field :validateuser, type: :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&UserResolver.validate_user/2)
    end
  end

  mutation do
    @desc "create a product"
    field :createproduct, type: :product do
      arg(:barcode, non_null(:string))
      arg(:name, :string)
      arg(:brand, :string)
      arg(:lastordered, :string)
      arg(:lastscan, :string)
      arg(:prlocation, :string)
      arg(:whlocation, :string)
      arg(:category, :string)
      arg(:price, :float)
      arg(:quantity, :integer)
      resolve(&ProductResolver.create_product/2)
    end

    @desc "create a user"
    field :createuser, type: :user do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      arg(:position, :string)
      arg(:email, :string)
      arg(:role, :string)
      resolve(&UserResolver.create_user/2)
    end

    @desc "delete a user"
    field :deleteuser, type: :user do
      arg(:id, non_null(:integer))
      resolve(&UserResolver.delete_user/2)
    end

    @desc "update a user"
    field :updateuser, type: :user do
      arg(:id, non_null(:integer))
      arg(:position, :string)
      arg(:role, :string)
      arg(:username, :string)
      arg(:email, :string)
      resolve(&UserResolver.update_user/2)
    end

    @desc "create an alarm"
    field :createalert, type: :alert do
      arg(:product, :integer)
      arg(:send, :string)
      arg(:quantity, :integer)
      arg(:condition, :string)
      arg(:category, :string)
      resolve(&AlertResolver.create_alert/2)
    end
    @desc "update an alert"
    field :updatealert, type: :alert do
      arg(:id, non_null(:integer))
      arg(:product, :integer)
      arg(:send, :string)
      arg(:quantity, :integer)
      arg(:condition, :string)
      arg(:category, :string)
      resolve(&AlertResolver.update_alert/2)
    end

    @desc "delete an alert"
    field :deletealert, type: :alert do
      arg(:id, non_null(:integer))
      resolve(&AlertResolver.delete_alert/2)
    end

    @desc "create a replenishment"
    field :createreplenishment, type: :replenishment do
      arg(:product, :integer)
      arg(:active, :boolean)
      arg(:quantity, :integer)
      arg(:condition, :string)
      arg(:email, :string)
      arg(:quantitytoorder, :integer)
      resolve(&ReplenishmentResolver.create_replenishment/2)
    end
    @desc "update a replenishment"
    field :updatereplenishment, type: :replenishment do
      arg(:id, non_null(:integer))
      arg(:product, :integer)
      arg(:active, :boolean)
      arg(:quantity, :integer)
      arg(:condition, :string)
      arg(:email, :string)
      arg(:quantitytoorder, :integer)
      resolve(&ReplenishmentResolver.update_replenishment/2)
    end

    @desc "delete a replenishment"
    field :deletereplenishment, type: :replenishment do
      arg(:id, non_null(:integer))
      resolve(&ReplenishmentResolver.delete_replenishment/2)
    end

  end
end
