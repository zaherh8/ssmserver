defmodule SsmserverWeb.AlertResolver do
  @moduledoc """
  This module is responsible for alert management
  """
  alias Ssmserver.Alerts

  def create_alert(args, _info) do
    Alerts.create_alert(args)
  end

  def get_alerts(_args, _info) do
    alerts = Alerts.list_alerts()
    {:ok, alerts}
  end

  def get_alert(args, _info) do
    {:ok, Alerts.get_alert!(Map.get(args, :id))}
  end

  def delete_alert(args, _info) do
    Alerts.delete_alert(Alerts.get_alert!(Map.get(args, :id)))
  end

  def update_alert(args, _info) do
    Alerts.update_alert(Alerts.get_alert!(Map.get(args, :id)), args)
  end
end
