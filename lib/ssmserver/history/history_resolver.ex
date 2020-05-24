defmodule SsmserverWeb.HistoryResolver do
  @moduledoc """
  This module is responsible for history management
  """
  alias Ssmserver.Histories
  alias SsmserverWeb.ProductResolver
  def create_history(args, _info) do
    Histories.create_history(args)
  end

  def get_history_list(_args, _info) do
    {:ok, products} = ProductResolver.get_products("","")

    historys = Histories.list_histories()
    |> Enum.map(fn hist ->
      hist = case Enum.find(products, fn prod ->
        prod.barcode == hist.product
      end) do
       product -> Map.put(hist, :name, product.name)
      end

    end)
    |>IO.inspect()
    {:ok, historys}
  end

  def get_history(args, _info) do
    {:ok, Histories.get_history!(Map.get(args, :id))}
  end

  def delete_history(args, _info) do
    Histories.delete_history(Histories.get_history!(Map.get(args, :id)))
  end

  def get_scans_total(_args,_info) do
   {:ok, %{total: Histories.get_total_scans()}}
  end
  def update_history(args, _info) do
    Histories.update_history(Histories.get_history!(Map.get(args, :id)), args)
  end
end
