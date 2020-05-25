defmodule SsmserverWeb.ProductResolver do
  @moduledoc """
  This module is responsible for product management
  """
  alias Ssmserver.Products.Product
  alias Ssmserver.Products
  alias Ecto.Multi
  alias Ssmserver.Repo
  alias SsmserverWeb.AlertResolver
  alias Ssmserver.Email
  alias Ssmserver.Mailer
  alias SsmserverWeb.UserResolver
  alias SsmserverWeb.ReplenishmentResolver
  alias SsmserverWeb.HistoryResolver
  require Logger

  def create_product(args, _info) do
    Products.create_product(args)
    {:ok, args}
  end

  def get_products(_args, _info) do
    products = Products.list_products()
    |> Enum.map(fn product ->
       Map.put(product, :prlocation, Enum.join(product.prlocation, ","))
    end)
    {:ok, products}
  end

  def get_available_products(_args, _info) do
    products = Products.list_available_products()
    |> Enum.map(fn product ->
      Map.put(product, :prlocation, Enum.join(product.prlocation, ","))
    end)
    {:ok, products}
  end

  def get_products_total(_args, _info) do
    {:ok, %{total: Products.get_products_total()}}
  end

  def get_brands_total(_args, _info) do
    {:ok, %{total: Products.get_brands_total()}}
  end

  def get_product(args, _info) do
    {:ok, Products.get_product!(Map.get(args, :barcode))}
  end

  def get_product_by_barcode(args, _info) do
    {:ok, Products.get_product_by(args)}
  end

  def delete_product(args, _info) do
    Products.delete_product(Products.get_product!(Map.get(args, :barcode)))
  end

  def update_products(%{products: products}, _info) do
    Products.all_product_to_zero("")

    res =
      case update_at_once(products) do
        {:ok, _} ->
          begin_tasks(products)
          {:ok, %{text: "All products are updated"}}

        _ ->
          {:error, %{text: "Oops, something went wrong. Please try again later."}}
      end

    res
  end

  def top_five_products(_args, _info) do
    {:ok,
    Products.get_products_sorted()
    |> Enum.take(5)
    }
  end

  def begin_tasks(new_products) do
    {:ok, products} = get_products("", "")
    task = Task.async(fn -> send_alerts(products) end)
    task2 = Task.async(fn -> send_replenishments(products) end)
    task3 = Task.async(fn -> update_history(new_products) end)
    Task.yield_many([task, task2, task3], 5000)
  end

  def update_history(products) do
    update_time =
      DateTime.utc_now()
      |> DateTime.to_string()

    Enum.each(products, fn prod ->
      HistoryResolver.create_history(
        %{product: prod.barcode, date: update_time, quantity: prod.quantity},
        ""
      )
    end)
  end

  def send_replenishments(products) do
    time =
      DateTime.utc_now()
      |> DateTime.to_string()

    {:ok, replenishments} = ReplenishmentResolver.get_replenishments("", "")

    replenishments
    |> Enum.each(fn rep ->
      Enum.each(products, fn product ->
        if product.barcode == rep.product &&
             ((rep.condition == "Less Than" && rep.quantity > product.quantity) ||
                (rep.condition == "more Than" && rep.quantity < product.quantity)) &&
             not rep.active do
          update_product(%{lastordered: time, barcode: product.barcode}, "")
          ReplenishmentResolver.update_replenishment_state(rep, %{active: true})

          Email.rep_email(rep.email, product.name, rep.quantitytoorder)
          |> Mailer.deliver_later()

          Logger.warn(
            "A replenishment of the following product '#{product.name}' to #{rep.email}"
          )
        end
      end)
    end)
  end

  def send_alerts(products) do
    # get all alerts a process /replenishments another process
    {:ok, alerts} = AlertResolver.get_alerts("", "")
    # get all products with quantity different than zero (to be added)

    {:ok, managers_emails} = UserResolver.get_managers_emails()

    alerts
    |> Enum.each(fn alert ->
      Enum.each(products, fn product ->
        if product.barcode == alert.product &&
             ((alert.condition == "Less Than" && alert.quantity > product.quantity) ||
                (alert.condition == "more Than" && alert.quantity < product.quantity)) do
          Email.alert_email(managers_emails, product.name)
          |> Mailer.deliver_later()

          Logger.warn(
            "A low stock inventory alert of the following product '#{product.name}' was sent to all managers"
          )
        end
      end)
    end)

    # for every new product parse the list of alerts and check the condition  if conditiond satisfied send an alert/replenishment
  end

  def update_at_once(args) do
    update_time =
      DateTime.utc_now()
      |> DateTime.to_string()

    Enum.reduce(args, Multi.new(), fn updated_product, multi ->
      updated_product =
        updated_product
        |> Map.put(:lastscan, update_time)

      Multi.update(
        multi,
        {:product, updated_product.barcode},
        Product.changeset(Products.get_product!(updated_product.barcode), updated_product)
      )
    end)
    |> Repo.transaction()
  end

  def update_product(args, _info) do
    Products.update_product(Products.get_product!(Map.get(args, :barcode)), args)
  end
end
