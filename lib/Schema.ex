defmodule SsmserverWeb.Schema do
  use Absinthe.Schema
  alias SsmserverWeb.AlertResolver
  alias SsmserverWeb.HistoryResolver
  alias SsmserverWeb.ProductResolver
  alias SsmserverWeb.ReplenishmentResolver
  alias SsmserverWeb.UserResolver

  import_types(SsmserverWeb.Types)

  query do
    @desc "return all products"
    field :products, type: list_of(:product) do
      resolve(&ProductResolver.get_products/2)
    end

    @desc "return top 5 products"
    field :top_five_products, type: list_of(:product) do
      resolve(&ProductResolver.top_five_products/2)
    end

    @desc "return total products quantity"
    field :products_quantity, type: :total do
      resolve(&ProductResolver.get_products_total/2)
    end
    @desc "return total active orders"
    field :active_orders, type: :total do
      resolve(&ReplenishmentResolver.get_active_orders/2)
    end

    @desc "return total brands quantity"
    field :brands_quantity, type: :total do
      resolve(&ProductResolver.get_brands_total/2)
    end

    @desc "return total brands quantity"
    field :scans_quantity, type: :total do
      resolve(&HistoryResolver.get_scans_total/2)
    end

    @desc "return all available products"
    field :available_products, type: list_of(:product) do
      resolve(&ProductResolver.get_available_products/2)
    end

    @desc "return all alerts"
    field :alerts, type: list_of(:alert) do
      resolve(&AlertResolver.get_alerts/2)
    end

    @desc "return all scans"
    field :history, type: list_of(:history_total) do
      resolve(&HistoryResolver.get_history_list_sorted_by_date/2)
    end

    @desc "return all alerts"
    field :replenishments, type: list_of(:replenishment) do
      resolve(&ReplenishmentResolver.get_replenishments/2)
    end

    @desc "return a product"
    field :getproduct, type: :product do
      arg(:barcode, non_null(:string))
      resolve(&ProductResolver.get_product_by_barcode/2)
    end

    @desc "return a product by barcode"
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
      arg(:prlocation,  list_of(:string))
      arg(:whlocation, :string)
      arg(:category, :string)
      arg(:price, :float)
      arg(:quantity, :integer)
      arg(:supplier, :string)
      resolve(&ProductResolver.create_product/2)
    end

    @desc "update a list of products"
    field :updateproducts, type: :message do
      arg(:products, non_null(list_of(:inputproduct)))
      resolve(&ProductResolver.update_products/2)
    end

    @desc "update a product"
    field :updateproduct, type: :product do
      arg(:barcode, non_null(:string))
      arg(:name, :string)
      arg(:brand, :string)
      arg(:lastordered, :string)
      arg(:lastscan, :string)
      arg(:prlocation, list_of(:string))
      arg(:whlocation, :string)
      arg(:category, :string)
      arg(:price, :float)
      arg(:quantity, :integer)
      arg(:supplier, :string)
      resolve(&ProductResolver.update_product/2)
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

    @desc "create an alert"
    field :createalert, type: :alert do
      arg(:product, :string)
      arg(:send, :string)
      arg(:quantity, :integer)
      arg(:condition, :string)
      arg(:category, :string)
      resolve(&AlertResolver.create_alert/2)
    end

    @desc "update an alert"
    field :updatealert, type: :alert do
      arg(:id, non_null(:integer))
      arg(:product, :string)
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
      arg(:product, :string)
      arg(:active, :boolean)
      arg(:quantity, :integer)
      arg(:condition, :string)
      arg(:email, :string)
      arg(:quantitytoorder, :integer)
      resolve(&ReplenishmentResolver.create_replenishment/2)
    end

    @desc "update a replenishment"
    field :updatereplenishment, type: :replenishment do
      arg(:id, :integer)
      arg(:product, :string)
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
