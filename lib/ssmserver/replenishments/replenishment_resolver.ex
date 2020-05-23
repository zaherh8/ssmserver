defmodule SsmserverWeb.ReplenishmentResolver do
  @moduledoc """
  This module is responsible for replenishment management
  """
  alias Ssmserver.Replenishments

  def create_replenishment(args, _info) do
    Replenishments.create_replenishment(args)
    {:ok, args}
  end

  def get_replenishments(_args, _info) do
    replenishments = Replenishments.list_replenishment()
    {:ok, replenishments}
  end

  def update_replenishment_state(replenishment, args) do
    Replenishments.update_replenishment(replenishment, args)
  end

  def get_replenishment(args, _info) do
    {:ok, Replenishments.get_replenishment!(Map.get(args, :id))}
  end

  def get_active_orders(_args, _info) do
    {:ok, %{total: Replenishments.get_active_orders()}}
  end
  def delete_replenishment(args, _info) do
    Replenishments.delete_replenishment(Replenishments.get_replenishment!(Map.get(args, :id)))
  end

  def update_replenishment(args, _info) do
    Replenishments.update_replenishment(
      Replenishments.get_replenishment!(Map.get(args, :id)),
      args
    )
  end
end
