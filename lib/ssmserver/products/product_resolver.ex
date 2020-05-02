defmodule SsmserverWeb.ProductResolver do
  @moduledoc """
  This module is responsible for product management
  """
  alias Ssmserver.Products

  def create_product(args, _info) do
    Products.create_product(args)
    {:ok, args}
  end

  def get_products(_args, _info) do
    products = Products.list_products()
    {:ok, products}
  end

  def get_product(args, _info) do
    {:ok, Products.get_product!(Map.get(args, :id))}
  end

  def get_product_by_barcode(args, _info) do
    {:ok, Products.get_product_by(args)}
  end

  def delete_product(args, _info) do
    Products.delete_product(Products.get_product!(Map.get(args, :id)))
  end

  def update_product(args, _info) do
    IO.inspect(args)
    # Products.update_product(Products.get_product!(Map.get(args, :id)), args)
    {:ok, %{text: "worked"}}
  end
end
